//
//  RemoteImageService.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import Foundation

public final class RemoteImageService: NSObject, ObservableObject {
    public typealias RemoteImageCacheKeyProvider = (RemoteImageType) -> AnyObject

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

extension RemoteImageService {
    private func fetchImage(atURL url: URL) {
        cancellable?.cancel()

        let cacheKey = Self.cacheKeyProvider(.url(url))
        if let image = Self.cache.object(forKey: cacheKey) {
            state = .image(image)
            return
        }

        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)

        cancellable = urlSession.dataTaskPublisher(for: urlRequest)
            .map { PlatformSpecificImageType(data: $0.data) }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let failure):
                        self.state = .error(failure)
                    default: ()
                }
            }) { image in
                if let image = image {
                    Self.cache.setObject(image, forKey: cacheKey)
                    self.state = .image(image)
                } else {
                    self.state = .error(RemoteImageServiceError.couldNotCreateImage)
                }
            }
    }

    private func fetchImage(withLocalIdentifier localIdentifier: String) {
        let cacheKey = Self.cacheKeyProvider(.phAsset(localIdentifier: localIdentifier))
        if let image = Self.cache.object(forKey: cacheKey) {
            state = .image(image)
            return
        }

        dependencies.photoKitService.getPhotoData(localIdentifier: localIdentifier, success: { data in
            if let image = PlatformSpecificImageType(data: data) {
                Self.cache.setObject(image, forKey: cacheKey)
                self.state = .image(image)
            } else {
                self.state = .error(RemoteImageServiceError.couldNotCreateImage)
            }
        }) { error in
            self.state = .error(error)
        }
    }
}
