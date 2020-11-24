//
//  MockRemoteImageServiceDependencies.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 15.12.19.
//

@testable import RemoteImage

struct MockRemoteImageServiceDependencies: DefaultRemoteImageServiceDependenciesProtocol {
    let photoKitService: PhotoKitServiceProtocol
    let remoteImageURLDataPublisher: RemoteImageURLDataPublisher

    init() {
        photoKitService = MockPhotoKitService()
        remoteImageURLDataPublisher = MockRemoteImageURLDataPublisher()
    }
}
