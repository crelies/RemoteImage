//
//  RemoteImageState.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum RemoteImageState: Hashable {
    case error(_ error: NSError)
    case image(_ image: UniversalImage)
    case loading
}

extension RemoteImageState {
    var error: NSError? {
        guard case let RemoteImageState.error(error) = self else {
            return nil
        }
        return error
    }

    var image: UniversalImage? {
        guard case let RemoteImageState.image(uiImage) = self else {
            return nil
        }
        return uiImage
    }
}
