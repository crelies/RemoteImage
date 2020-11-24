//
//  RemoteImageType.swift
//  RemoteImage
//
//  Created by Christian Elies on 29.10.19.
//

import Foundation

public enum RemoteImageType {
    @available(*, deprecated, message: "Will be removed in the future because the localIdentifier is device specific and therefore cannot be used to uniquely identify a PHAsset across devices.")
    case phAsset(localIdentifier: String)
    case url(_ url: URL)
}
