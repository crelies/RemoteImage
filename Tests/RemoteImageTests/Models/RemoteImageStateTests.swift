//
//  RemoteImageStateTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 23.02.20.
//

#if canImport(UIKit)
@testable import RemoteImage
import UIKit
import XCTest

final class RemoteImageStateTests: XCTestCase {
    func testErrorValue() {
        let error = NSError(domain: "MockDomain", code: 1, userInfo: nil)
        let state: RemoteImageState = .error(error)
        XCTAssertEqual(state.error, error)
    }

    func testNoErrorValue() {
        let state: RemoteImageState = .loading
        XCTAssertNil(state.error)
    }

    func testImageValue() {
        let image = UIImage()
        let state: RemoteImageState = .image(image)
        XCTAssertEqual(state.image, image)
    }

    func testNoImageValue() {
        let state: RemoteImageState = .loading
        XCTAssertNil(state.image)
    }

    static var allTests = [
        ("testErrorValue", testErrorValue),
        ("testNoErrorValue", testNoErrorValue),
        ("testImageValue", testImageValue),
        ("testNoImageValue", testNoImageValue)
    ]
}
#endif
