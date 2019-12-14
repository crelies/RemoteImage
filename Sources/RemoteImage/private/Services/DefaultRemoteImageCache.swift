//
//  DefaultRemoteImageCache.swift
//  
//
//  Created by Christian Elies on 14.12.19.
//

import Foundation

struct DefaultRemoteImageCache {
    let cache = NSCache<AnyObject, PlatformSpecificImageType>()
}

extension DefaultRemoteImageCache: RemoteImageCache {
    func object(forKey key: AnyObject) -> PlatformSpecificImageType? { cache.object(forKey: key) }

    func setObject(_ object: PlatformSpecificImageType, forKey key: AnyObject) { cache.setObject(object, forKey: key) }
}
