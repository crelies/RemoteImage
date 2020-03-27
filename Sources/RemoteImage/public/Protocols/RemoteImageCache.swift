//
//  RemoteImageCache.swift
//  
//
//  Created by Christian Elies on 14.12.19.
//

#if canImport(UIKit)
import UIKit

public protocol RemoteImageCache {
    func object(forKey key: AnyObject) -> UIImage?
    func setObject(_ object: UIImage, forKey key: AnyObject)
    func removeObject(forKey key: AnyObject)
    func removeAllObjects()
}
#endif
