//
//  RemoteImageState.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum RemoteImageState {
    case error(_ error: Error)
    case image(_ image: RemoteImageType)
    case loading
}

extension RemoteImageState: Equatable {
    static func == (lhs: RemoteImageState, rhs: RemoteImageState) -> Bool {
        switch (lhs, rhs) {
            case (.error(let lhsError), .error(let rhsError)):
                return (lhsError as NSError) == (rhsError as NSError)
            case (.image(let lhsImage), .image(let rhsImage)):
                return lhsImage == rhsImage
            case (.loading, .loading):
                return true
            default:
                return false
        }
    }
}
