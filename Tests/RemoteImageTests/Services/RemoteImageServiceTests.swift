//
//  RemoteImageServiceTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

#if canImport(SwiftUI) && canImport(UIKit)
import Combine
@testable import RemoteImage
import SwiftUI
import UIKit
import XCTest

final class RemoteImageServiceTests: XCTestCase {
    private var cancellable: AnyCancellable?

    let dependencies = MockRemoteImageServiceDependencies()
    lazy var photoKitService = dependencies.photoKitService as? MockPhotoKitService
    lazy var remoteImageURLDataPublisher = dependencies.remoteImageURLDataPublisher as? MockRemoteImageURLDataPublisher
    lazy var service = DefaultRemoteImageService(dependencies: dependencies)

    override func setUp() {
        DefaultRemoteImageService.cache.removeAllObjects()
        photoKitService?.resultToReturn = .success(Data())
    }

    func testFetchImageURLSuccess() {
        guard let url = URL(string: "https://www.google.de") else {
            XCTFail("Could not create mock URL")
            return
        }

        guard let data = UIImage(systemName: "paperplane.fill")?.jpegData(compressionQuality: 1) else {
            XCTFail("Could not create mock data")
            return
        }

        let expectation = self.expectation(description: "FetchImageURL")
        let response = URLResponse()
        let remoteImageType: RemoteImageType = .url(url)
        service.fetchImage(ofType: remoteImageType)

        // publish mock data
        remoteImageURLDataPublisher?.publisher.send((data: data, response: response))

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.image = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .image(let image):
            XCTAssertNotNil(image.imageAsset)
        default:
            XCTFail("Invalid fetch image URL result")
        }
    }

    func testFetchImageURLFailure() {
        guard let url = URL(string: "https://www.google.de") else {
            XCTFail("Could not create mock URL")
            return
        }

        let data = Data()

        let expectation = self.expectation(description: "FetchImageURL")
        let response = URLResponse()
        let remoteImageType: RemoteImageType = .url(url)
        service.fetchImage(ofType: remoteImageType)

        // publish mock data
        remoteImageURLDataPublisher?.publisher.send((data: data, response: response))

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.error = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .error(let error):
            XCTAssertEqual(error as? RemoteImageServiceError, .couldNotCreateImage)
        default:
            XCTFail("Invalid fetch image URL result")
        }
    }

    func testFetchImageURLFailureCompletion() {
        guard let url = URL(string: "https://www.google.de") else {
            XCTFail("Could not create mock URL")
            return
        }

        let expectation = self.expectation(description: "FetchImageURLState")

        let remoteImageType: RemoteImageType = .url(url)
        service.fetchImage(ofType: remoteImageType)

        // publish completion
        let expectedError = URLError(.cancelled)
        remoteImageURLDataPublisher?.publisher.send(completion: .failure(expectedError))

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.error = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .error(let error):
            XCTAssertEqual(error as? URLError, expectedError)
        default:
            XCTFail("Invalid fetch image URL completion")
        }
    }

    func testFetchImageURLCached() {
        guard let url = URL(string: "https://www.google.de") else {
            XCTFail("Could not create mock URL")
            return
        }

        guard let image = UIImage(systemName: "paperplane.fill") else {
            XCTFail("Could not create mock image")
            return
        }

        let cacheKey = url as NSURL
        DefaultRemoteImageService.cache.setObject(image, forKey: cacheKey)

        let expectation = self.expectation(description: "FetchImageURLCached")
        let remoteImageType: RemoteImageType = .url(url)
        service.fetchImage(ofType: remoteImageType)

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.image = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .image(let image):
            XCTAssertNotNil(image.imageAsset)
        default:
            XCTFail("Invalid fetch image URL cached result")
        }
    }

    func testFetchPHAssetSuccess() {
        guard let data = UIImage(systemName: "paperplane.fill")?.jpegData(compressionQuality: 1) else {
            XCTFail("Could not create mock data")
            return
        }

        let expectation = self.expectation(description: "FetchPHAsset")
        photoKitService?.resultToReturn = .success(data)
        let localIdentifier = "TestIdentifier"
        let remoteImageType: RemoteImageType = .phAsset(localIdentifier: localIdentifier)
        service.fetchImage(ofType: remoteImageType)

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.image = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .image(let image):
            XCTAssertNotNil(image.imageAsset)
        default:
            XCTFail("Invalid fetch ph asset result")
        }
    }

    func testFetchPHAccessInvalidData() {
        let expectation = self.expectation(description: "FetchPHAsset")
        photoKitService?.resultToReturn = .success(Data())
        let localIdentifier = "TestIdentifier"
        let remoteImageType: RemoteImageType = .phAsset(localIdentifier: localIdentifier)
        service.fetchImage(ofType: remoteImageType)

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.error = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .error(let error):
            XCTAssertEqual(error as? RemoteImageServiceError, .couldNotCreateImage)
        default:
            XCTFail("Invalid fetch ph asset result")
        }
    }

    func testFetchPHAccessFailure() {
        let expectation = self.expectation(description: "FetchPHAsset")
        let expectedError: RemoteImageServiceError = .couldNotCreateImage
        photoKitService?.resultToReturn = .failure(expectedError)
        let localIdentifier = "TestIdentifier"
        let remoteImageType: RemoteImageType = .phAsset(localIdentifier: localIdentifier)
        service.fetchImage(ofType: remoteImageType)

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.error = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .error(let error):
            XCTAssertEqual(error as? RemoteImageServiceError, expectedError)
        default:
            XCTFail("Invalid fetch ph asset result")
        }
    }

    func testFetchPHAssetCached() {
        guard let image = UIImage(systemName: "paperplane.fill") else {
            XCTFail("Could not create mock image")
            return
        }

        let localIdentifier = "TestIdentifier"
        let cacheKey = localIdentifier as NSString
        DefaultRemoteImageService.cache.setObject(image, forKey: cacheKey)

        let expectation = self.expectation(description: "FetchPHAssetCached")
        let remoteImageType: RemoteImageType = .phAsset(localIdentifier: localIdentifier)
        service.fetchImage(ofType: remoteImageType)

        var state: RemoteImageState?
        cancellable = service.$state.sink { st in
            guard case RemoteImageState.image = st else {
                return
            }
            state = st
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        switch state {
        case .image(let image):
            XCTAssertNotNil(image.imageAsset)
        default:
            XCTFail("Invalid fetch ph asset cached result")
        }
    }

    static var allTests = [
        ("testFetchImageURLSuccess", testFetchImageURLSuccess),
        ("testFetchImageURLFailure", testFetchImageURLFailure),
        ("testFetchImageURLFailureCompletion", testFetchImageURLFailureCompletion),
        ("testFetchImageURLCached", testFetchImageURLCached),
        ("testFetchPHAssetSuccess", testFetchPHAssetSuccess),
        ("testFetchPHAccessInvalidData", testFetchPHAccessInvalidData),
        ("testFetchPHAccessFailure", testFetchPHAccessFailure),
        ("testFetchPHAssetCached", testFetchPHAssetCached)
    ]
}
#endif
