//
//  DefaultRemoteImageCache.swift
//  RemoteImage
//
//  Created by Christian Elies on 14.12.19.
//

import Foundation

struct DefaultRemoteImageCache {
    let cache = NSCache<AnyObject, UniversalImage>()
}

extension DefaultRemoteImageCache: RemoteImageCache {
    func object(forKey key: AnyObject) -> UniversalImage? { cache.object(forKey: key) }

    func setObject(_ object: UniversalImage, forKey key: AnyObject) { cache.setObject(object, forKey: key) }

    func removeObject(forKey key: AnyObject) { cache.removeObject(forKey: key) }

    func removeAllObjects() { cache.removeAllObjects() }
}
