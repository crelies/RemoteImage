//
//  RemoteImageService.swift
//  RemoteImage
//
//  Created by Christian Elies on 15.12.19.
//

import Combine

public typealias RemoteImageCacheKeyProvider = (RemoteImageType) -> AnyObject

/// Represents the service associated with a `RemoteImage` view. Responsible for fetching the image and managing the state.
public protocol RemoteImageService where Self: ObservableObject {
    /// The cache for the images fetched by any instance of `RemoteImageService`.
    static var cache: RemoteImageCache { get set }
    /// Provides a key for a given `RemoteImageType` used for storing an image in the cache.
    static var cacheKeyProvider: RemoteImageCacheKeyProvider { get set }

    /// The current state of the image fetching process - `loading`, `error` or `image (success)`.
    var state: RemoteImageState { get set }

    /// Fetches the image with the given type.
    ///
    /// - Parameter type: Specifies the source type of the remote image. Choose between `.url` or `.phAsset`.
    func fetchImage(ofType type: RemoteImageType)
}
