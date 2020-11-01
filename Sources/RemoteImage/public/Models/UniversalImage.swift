//
//  UniversalImage.swift
//  RemoteImage
//
//  Created by Christian Elies on 01.11.20.
//

#if os(iOS)
import UIKit

public typealias UniversalImage = UIImage

#elseif os(macOS)

import AppKit

public typealias UniversalImage = NSImage

#endif
