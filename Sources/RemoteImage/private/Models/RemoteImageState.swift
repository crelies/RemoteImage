//
//  RemoteImageState.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum RemoteImageState {
    case error(_ error: NSError)
    case image(_ image: PlatformSpecificImageType)
    case loading
}
