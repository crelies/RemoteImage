//
//  RemoteImageCache.swift
//  
//
//  Created by Christian Elies on 14.12.19.
//

import Foundation

public protocol RemoteImageCache {
    func object(forKey key: AnyObject) -> PlatformSpecificImageType?
    func setObject(_ object: PlatformSpecificImageType, forKey key: AnyObject)
    func removeObject(forKey key: AnyObject)
    func removeAllObjects()
}
