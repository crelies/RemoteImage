//
//  MockRemoteImageURLDataPublisher.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

import Combine
import Foundation
@testable import RemoteImage

final class MockRemoteImageURLDataPublisher: RemoteImageURLDataPublisher {
    var publisher = PassthroughSubject<(data: Data, response: URLResponse), URLError>()

    func dataPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        publisher.eraseToAnyPublisher()
    }
}
