//
//  PhotoKitServiceTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

@testable import RemoteImage
import Photos
import XCTest

final class PhotoKitServiceTests: XCTestCase {
    let imageManager = MockImageManager()
    let asset = MockPHAsset()
    let service = PhotoKitService()
    let localIdentifier = "TestIdentifier"

    override func setUp() {
        PhotoKitService.asset = MockPHAsset.self
        PhotoKitService.imageManager = imageManager

        MockPHAsset.fetchResult.firstObjectToReturn = nil
        imageManager.dataToReturn = nil
        imageManager.infoToReturn = nil
    }

    func testPhotoDataNotFound() {
        let expectation = self.expectation(description: "PhotoDataResult")
        var result: Result<Data, Error>?
        service.getPhotoData(localIdentifier: localIdentifier) { res in
            result = res
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)

        switch result {
        case .failure(let error):
            guard case PhotoKitServiceError.phAssetNotFound(localIdentifier) = error else {
                XCTFail("Invalid error")
                return
            }
        default:
            XCTFail("Invalid photo data result")
        }
    }

    func testPhotoDataFailure() {
        MockPHAsset.fetchResult.firstObjectToReturn = asset
        imageManager.infoToReturn = [PHImageErrorKey: PhotoKitServiceError.missingData]

        let expectation = self.expectation(description: "PhotoDataResult")
        var result: Result<Data, Error>?
        service.getPhotoData(localIdentifier: localIdentifier) { res in
            result = res
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)

        switch result {
        case .failure(let error):
            XCTAssertEqual(error as? PhotoKitServiceError, .missingData)
        default:
            XCTFail("Invalid photo data result")
        }
    }

    func testPhotoDataSuccess() {
        let expectedData = Data()
        MockPHAsset.fetchResult.firstObjectToReturn = asset
        imageManager.dataToReturn = expectedData

        let expectation = self.expectation(description: "PhotoDataResult")
        var result: Result<Data, Error>?
        service.getPhotoData(localIdentifier: localIdentifier) { res in
            result = res
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)

        switch result {
        case .success(let data):
            XCTAssertEqual(data, expectedData)
        default:
            XCTFail("Invalid photo data result")
        }
    }

    static var allTests = [
        ("testPhotoDataNotFound", testPhotoDataNotFound),
        ("testPhotoDataFailure", testPhotoDataFailure),
        ("testPhotoDataSuccess", testPhotoDataSuccess)
    ]
}
