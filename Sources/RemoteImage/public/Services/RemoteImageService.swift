//
//  RemoteImageService.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import UIKit

public final class RemoteImageService: ObservableObject {
    private var cancellable: AnyCancellable?
    
    var state: RemoteImageState = .loading {
        didSet {
            objectWillChange.send()
        }
    }
    
    public static let cache = NSCache<NSString, UIImage>()
    
    public static let overrideCacheKey: (URL) -> String = { $0.absoluteString }
    
    public let objectWillChange = PassthroughSubject<Void, Never>()
    
    func fetchImage(atURL url: URL) {
        cancellable?.cancel()
        
        let cacheKey = RemoteImageService.overrideCacheKey(url) as NSString
        
        if let image = RemoteImageService.cache.object(forKey: cacheKey) {
            state = .image(image)
            return
        }
        
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        cancellable = urlSession.dataTaskPublisher(for: urlRequest)
            .map { UIImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let failure):
                        self.state = .error(failure)
                    default: ()
                }
            }) { image in
                if let image = image {
                    RemoteImageService.cache.setObject(image, forKey: cacheKey)
                    self.state = .image(image)
                } else {
                    self.state = .error(RemoteImageServiceError.couldNotCreateImage)
                }
            }
    }
}
