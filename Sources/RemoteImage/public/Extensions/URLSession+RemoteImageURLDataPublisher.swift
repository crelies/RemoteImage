//
//  URLSession+RemoteImageURLDataPublisher.swift
//  RemoteImage
//
//  Created by Christian Elies on 15.12.19.
//

import Combine
import Foundation

extension URLSession: RemoteImageURLDataPublisher {
    public func dataPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}
