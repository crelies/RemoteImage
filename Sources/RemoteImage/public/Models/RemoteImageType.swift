//
//  RemoteImageType.swift
//  RemoteImage
//
//  Created by Christian Elies on 29.10.19.
//

import Foundation

public enum RemoteImageType {
    case phAsset(localIdentifier: String)
    case url(_ url: URL)
}
