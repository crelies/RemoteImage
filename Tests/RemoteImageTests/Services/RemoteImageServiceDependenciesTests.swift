//
//  RemoteImageServiceDependenciesTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

import Foundation
@testable import RemoteImage
import XCTest

final class RemoteImageServiceDependenciesTests: XCTestCase {
    func testInitialization() {
        let dependencies = RemoteImageServiceDependencies()
        XCTAssertTrue(dependencies.photoKitService is PhotoKitService)
        XCTAssertTrue(dependencies.remoteImageURLDataPublisher is URLSession)
    }

    static var allTests = [
        ("testInitialization", testInitialization)
    ]
}
