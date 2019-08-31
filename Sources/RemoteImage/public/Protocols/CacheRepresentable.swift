//
//  CacheRepresentable.swift
//  RemoteImage
//
//  Created by Wilson Gramer on 30.08.19.
//

import Foundation
import UIKit

public protocol CacheRepresentable {
    func setObject(_ obj: UIImage, forKey key: NSString)
    func object(forKey key: NSString) -> UIImage?
}
