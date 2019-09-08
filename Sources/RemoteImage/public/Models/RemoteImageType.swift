//
//  RemoteImageType.swift
//  
//
//  Created by Christian Elies on 08.09.19.
//

import Foundation

#if canImport(UIKit) && !targetEnvironment(macCatalyst)
import UIKit
public typealias RemoteImageType = UIImage
#elseif targetEnvironment(macCatalyst)
import AppKit
public typealias RemoteImageType = NSImage
#else
import AppKit
public typealias RemoteImageType = NSImage
#endif
