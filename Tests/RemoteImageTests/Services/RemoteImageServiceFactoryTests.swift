//
//  RemoteImageServiceFactoryTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

@testable import RemoteImage
import XCTest

final class RemoteImageServiceFactoryTests: XCTestCase {
    func testMakeRemoteImageService() {
        let service = RemoteImageServiceFactory.makeRemoteImageService()
        XCTAssertEqual(service.state, .loading)
    }
}
