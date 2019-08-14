//
//  RemoteImageServiceError.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum RemoteImageServiceError: Error {
    case couldNotCreateImage
}

extension RemoteImageServiceError: LocalizedError {
    var errorDescription: String? {
        return "Could not create image from received data"
    }
}
