//
//  RemoteImageCache.swift
//  RemoteImage
//
//  Created by Christian Elies on 14.12.19.
//

public protocol RemoteImageCache {
    func object(forKey key: AnyObject) -> UniversalImage?
    func setObject(_ object: UniversalImage, forKey key: AnyObject)
    func removeObject(forKey key: AnyObject)
    func removeAllObjects()
}
