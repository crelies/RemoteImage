//
//  URLSession+RemoteImageURLDataPublisherTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

import Foundation
@testable import RemoteImage
import XCTest

final class URLSession_RemoteImageURLDataPublisherTests: XCTestCase {
    func testDataPublisher() {
        guard let url = URL(string: "https://google.de") else {
            XCTFail("Could not create mock URL")
            return
        }
        let urlSession: URLSession = .shared
        let urlRequest = URLRequest(url: url)
        let dataTaskPublisher = urlSession.dataTaskPublisher(for: urlRequest).eraseToAnyPublisher()
        let dataPublisher = urlSession.dataPublisher(for: urlRequest)
        XCTAssertEqual(dataPublisher.description, dataTaskPublisher.description)
    }

    static var allTests = [
        ("testDataPublisher", testDataPublisher)
    ]
}
