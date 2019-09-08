//
//  RemoteImageType.swift
//  
//
//  Created by Christian Elies on 08.09.19.
//

import Foundation

#if canImport(UIKit)
import UIKit
public typealias RemoteImageType = UIImage
#elseif os(macOS)
import AppKit
public typealias RemoteImageType = NSImage
#endif
