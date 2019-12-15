//
//  URLSession+RemoteImageURLDataPublisher.swift
//  RemoteImage
//
//  Created by Christian Elies on 15.12.19.
//

import Combine
import Foundation

extension URLSession: RemoteImageURLDataPublisher {
    func dataPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
