//
//  RemoteImageService.swift
//  RemoteImage
//
//  Created by Christian Elies on 15.12.19.
//

import Combine

public typealias RemoteImageCacheKeyProvider = (RemoteImageType) -> AnyObject

public protocol RemoteImageService where Self: ObservableObject {
    static var cache: RemoteImageCache { get set }
    static var cacheKeyProvider: RemoteImageCacheKeyProvider { get set }

    var state: RemoteImageState { get set }
    func fetchImage(ofType type: RemoteImageType)
}
