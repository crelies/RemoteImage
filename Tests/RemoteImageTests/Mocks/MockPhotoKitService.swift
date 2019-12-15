//
//  MockPhotoKitService.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

import Foundation
@testable import RemoteImage

final class MockPhotoKitService: PhotoKitServiceProtocol {
    var resultToReturn: Result<Data, Error> = .success(Data())

    func getPhotoData(localIdentifier: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        completion(resultToReturn)
    }
}
