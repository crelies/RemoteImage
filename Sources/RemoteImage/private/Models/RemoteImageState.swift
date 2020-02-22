//
//  RemoteImageState.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

#if canImport(UIKit)
import UIKit

enum RemoteImageState: Hashable {
    case error(_ error: NSError)
    case image(_ image: UIImage)
    case loading
}

extension RemoteImageState {
    var error: NSError? {
        guard case let RemoteImageState.error(error) = self else {
            return nil
        }
        return error
    }

    var image: UIImage? {
        guard case let RemoteImageState.image(uiImage) = self else {
            return nil
        }
        return uiImage
    }
}
#endif
