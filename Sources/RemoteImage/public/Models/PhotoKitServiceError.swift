//
//  PhotoKitServiceError.swift
//  RemoteImage
//
//  Created by Christian Elies.
//

import Foundation

public enum PhotoKitServiceError: Error {
    case missingData
    case phAssetNotFound(localIdentifier: String)
}

extension PhotoKitServiceError: Equatable {}

extension PhotoKitServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingData:
            return "The asset could not be loaded."
        case .phAssetNotFound(let localIdentifier):
            return "A PHAsset with the identifier \(localIdentifier) was not found."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .missingData:
            return "The asset data could not be fetched. Maybe you are not connected to the internet."
        case .phAssetNotFound(let localIdentifier):
            return "An asset with the identifier \(localIdentifier) doesn't exist anymore."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .missingData:
            return "Check your internet connection or try again later."
        default:
            return nil
        }
    }
}

extension PhotoKitServiceError: CustomNSError {
    public static var errorDomain: String { String(describing: PhotoKitService.self) }

    public var errorCode: Int {
        switch self {
        case .missingData:
            return 0
        case .phAssetNotFound:
            return 1
        }
    }
}
