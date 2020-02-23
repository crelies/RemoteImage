//
//  RemoteImageTests.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 22.02.20.
//

#if canImport(UIKit)
@testable import RemoteImage
import SwiftUI
import ViewInspector
import XCTest

final class RemoteImageTests: XCTestCase {
    private let fileManager: FileManager = .default
    private lazy var mockImageURL = URL(fileURLWithPath: "\(fileManager.currentDirectoryPath)/mock.jpeg")
    private let errorStateViewString = "Error"
    private lazy var errorView = Text(errorStateViewString)
    private let loadingStateViewString = "Loading ..."
    private lazy var loadingView = Text(loadingStateViewString)

    func testLoadingState() {
        let view = RemoteImage(type: .url(mockImageURL),
                               errorView: { _ in self.errorView },
                               imageView: { image in image },
                               loadingView: { self.loadingView })

        do {
            let inspectableView = try view.body.inspect()
            let group = try inspectableView.group().first
            let textString = try group?.text().string()
            XCTAssertEqual(textString, loadingStateViewString)
        } catch {
            XCTFail("\(error)")
        }
    }

    static var allTests = [
        ("testLoadingState", testLoadingState)
    ]
}
#endif
