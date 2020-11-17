//
//  RemoteImageService.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import Foundation

public typealias RemoteImageCacheKeyProvider = (RemoteImageType) -> AnyObject

public final class RemoteImageService: NSObject, ObservableObject, RemoteImageServiceProtocol {
    private let dependencies: RemoteImageServiceDependenciesProtocol
    private var cancellable: AnyCancellable?

    @Published var state: RemoteImageState = .loading

    public static var cache: RemoteImageCache = DefaultRemoteImageCache()
    public static var cacheKeyProvider: RemoteImageCacheKeyProvider = { remoteImageType in
        switch remoteImageType {
        case .phAsset(let localIdentifier): return localIdentifier as NSString
        case .url(let url): return url as NSURL
        }
    }

    init(dependencies: RemoteImageServiceDependenciesProtocol) {
        self.dependencies = dependencies
    }

    func fetchImage(ofType type: RemoteImageType) {
        switch type {
        case .url(let url):
            fetchImage(atURL: url)
        case .phAsset(let localIdentifier):
            fetchImage(withLocalIdentifier: localIdentifier)
        }
    }
}

private extension RemoteImageService {
    func fetchImage(atURL url: URL) {
        cancellable?.cancel()

        let cacheKey = Self.cacheKeyProvider(.url(url))
        if let image = Self.cache.object(forKey: cacheKey) {
            state = .image(image)
            return
        }

        cancellable = dependencies.remoteImageURLDataPublisher.dataPublisher(for: url)
            .map { UniversalImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let weakSelf = self else {
                    return
                }

                switch completion {
                    case .failure(let error):
                        weakSelf.state = .error(error as NSError)
                    case .finished: ()
                }
            }) { [weak self] image in
                guard let weakSelf = self else {
                    return
                }

                if let image = image {
                    Self.cache.setObject(image, forKey: cacheKey)
                    weakSelf.state = .image(image)
                } else {
                    weakSelf.state = .error(RemoteImageServiceError.couldNotCreateImage as NSError)
                }
            }
    }

    func fetchImage(withLocalIdentifier localIdentifier: String) {
        let cacheKey = Self.cacheKeyProvider(.phAsset(localIdentifier: localIdentifier))
        if let image = Self.cache.object(forKey: cacheKey) {
            state = .image(image)
            return
        }

        dependencies.photoKitService.getPhotoData(localIdentifier: localIdentifier) { result in
            switch result {
            case .success(let data):
                if let image = UniversalImage(data: data) {
                    Self.cache.setObject(image, forKey: cacheKey)
                    self.state = .image(image)
                } else {
                    self.state = .error(RemoteImageServiceError.couldNotCreateImage as NSError)
                }
            case .failure(let error):
                self.state = .error(error as NSError)
            }
        }
    }
}
