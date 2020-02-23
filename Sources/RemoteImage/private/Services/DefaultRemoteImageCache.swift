//
//  DefaultRemoteImageCache.swift
//  
//
//  Created by Christian Elies on 14.12.19.
//

#if canImport(UIKit)
import UIKit

struct DefaultRemoteImageCache {
    let cache = NSCache<AnyObject, UIImage>()
}

extension DefaultRemoteImageCache: RemoteImageCache {
    func object(forKey key: AnyObject) -> UIImage? { cache.object(forKey: key) }

    func setObject(_ object: UIImage, forKey key: AnyObject) { cache.setObject(object, forKey: key) }

    func removeObject(forKey key: AnyObject) { cache.removeObject(forKey: key) }

    func removeAllObjects() { cache.removeAllObjects() }
}
#endif
