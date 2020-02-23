//
//  RemoteImageServiceErrorTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 14.12.19.
//

@testable import RemoteImage
import XCTest

final class RemoteImageServiceErrorTests: XCTestCase {
    func testCouldNotCreateImageDescription() {
        let description = RemoteImageServiceError.couldNotCreateImage.errorDescription
        let expectedDescription = "Could not create image from received data"
        XCTAssertEqual(description, expectedDescription)
    }

    static var allTests = [
        ("testCouldNotCreateImageDescription", testCouldNotCreateImageDescription)
    ]
}
