//
//  RemoteImageServiceTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

import Combine
@testable import RemoteImage
import XCTest

final class RemoteImageServiceTests: XCTestCase {
    private var cancellable: AnyCancellable?

    let dependencies = MockRemoteImageServiceDependencies()
    lazy var photoKitService = dependencies.photoKitService as? MockPhotoKitService
    lazy var remoteImageURLDataPublisher = dependencies.remoteImageURLDataPublisher as? MockRemoteImageURLDataPublisher
    lazy var service = RemoteImageService(dependencies: dependencies)

    override func setUp() {
        RemoteImageService.cache.removeAllObjects()
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

    func testFetchImageURLCached() {
        guard let url = URL(string: "https://www.google.de") else {
            XCTFail("Could not create mock URL")
            return
        }

        guard let image = PlatformSpecificImageType(systemName: "paperplane.fill") else {
            XCTFail("Could not create mock image")
            return
        }

        let cacheKey = url as NSURL
        RemoteImageService.cache.setObject(image, forKey: cacheKey)

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

    func testFetchPHAccessFailure() {
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

    func testFetchPHAssetCached() {
        guard let image = PlatformSpecificImageType(systemName: "paperplane.fill") else {
            XCTFail("Could not create mock image")
            return
        }

        let localIdentifier = "TestIdentifier"
        let cacheKey = localIdentifier as NSString
        RemoteImageService.cache.setObject(image, forKey: cacheKey)

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
}
