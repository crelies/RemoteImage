//
//  RemoteImageServiceProtocol.swift
//  RemoteImage
//
//  Created by Christian Elies on 15.12.19.
//

#if canImport(UIKit)
import Combine

protocol RemoteImageServiceProtocol where Self: ObservableObject {
    static var cache: RemoteImageCache { get set }
    static var cacheKeyProvider: RemoteImageCacheKeyProvider { get set }

    var state: RemoteImageState { get set }
    func fetchImage(ofType type: RemoteImageType)
}
#endif
