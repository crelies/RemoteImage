//
//  RemoteImageServiceFactoryTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

#if canImport(UIKit)
@testable import RemoteImage
import XCTest

final class RemoteImageServiceFactoryTests: XCTestCase {
    func testMakeRemoteImageService() {
        let service = DefaultRemoteImageServiceFactory.makeDefaultRemoteImageService(remoteImageURLDataPublisher: URLSession.shared)
        XCTAssertEqual(service.state, .loading)
    }

    static var allTests = [
        ("testMakeRemoteImageService", testMakeRemoteImageService)
    ]
}
#endif
