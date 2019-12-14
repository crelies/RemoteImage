//
//  PhotoKitServiceErrorTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 14.12.19.
//

@testable import RemoteImage
import XCTest

final class PhotoKitServiceErrorTests: XCTestCase {
    let localIdentifier = "TestIdentifier"

    func testMissingDataErrorDescription() {
        let error: PhotoKitServiceError = .missingData
        let expectedErrorDescription = "The asset could not be loaded."
        XCTAssertEqual(error.errorDescription, expectedErrorDescription)
    }

    func testMissingDataFailureReason() {
        let error: PhotoKitServiceError = .missingData
        let expectedFailureReason = "The asset data could not be fetched. Maybe you are not connected to the internet."
        XCTAssertEqual(error.failureReason, expectedFailureReason)
    }

    func testMissingDataRecoverySuggestion() {
        let error: PhotoKitServiceError = .missingData
        let expectedRecoverySuggestion = "Check your internet connection or try again later."
        XCTAssertEqual(error.recoverySuggestion, expectedRecoverySuggestion)
    }

    func testMissingDataErrorCode() {
        let error: PhotoKitServiceError = .missingData
        let expectedErrorCode: Int = 0
        XCTAssertEqual(error.errorCode, expectedErrorCode)
    }

    func testPhAssetNotFoundErrorDescription() {
        let error: PhotoKitServiceError = .phAssetNotFound(localIdentifier: localIdentifier)
        let expectedErrorDescription = "A PHAsset with the identifier \(localIdentifier) was not found."
        XCTAssertEqual(error.errorDescription, expectedErrorDescription)
    }

    func testPhAssetNotFoundFailureReason() {
        let error: PhotoKitServiceError = .phAssetNotFound(localIdentifier: localIdentifier)
        let expectedFailureReason = "An asset with the identifier \(localIdentifier) doesn't exist anymore."
        XCTAssertEqual(error.failureReason, expectedFailureReason)
    }

    func testPhAssetNotFoundRecoverySuggestion() {
        let error: PhotoKitServiceError = .phAssetNotFound(localIdentifier: localIdentifier)
        XCTAssertNil(error.recoverySuggestion)
    }

    func testPhAssetNotFoundErrorCode() {
        let error: PhotoKitServiceError = .phAssetNotFound(localIdentifier: localIdentifier)
        let expectedErrorCode: Int = 1
        XCTAssertEqual(error.errorCode, expectedErrorCode)
    }

    func testErrorDomain() {
        XCTAssertEqual(PhotoKitServiceError.errorDomain, String(describing: PhotoKitService.self))
    }
}
