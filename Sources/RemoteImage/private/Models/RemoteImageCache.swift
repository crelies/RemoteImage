//
//  RemoteImageCache.swift
//  RemoteImage
//
//  Created by Wilson Gramer on 30.08.19.
//

import Foundation
import UIKit

struct RemoteImageCache: CacheRepresentable {
    let cache = NSCache<NSString, UIImage>()

    func setObject(_ obj: UIImage, forKey key: NSString) {
        self.cache.setObject(obj, forKey: key)
    }

    func object(forKey key: NSString) -> UIImage? {
        return self.cache.object(forKey: key)
    }
}
