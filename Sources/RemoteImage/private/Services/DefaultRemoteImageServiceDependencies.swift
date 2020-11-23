//
//  DefaultRemoteImageServiceDependencies.swift
//  RemoteImage
//
//  Created by Christian Elies on 29.10.19.
//

import Foundation

protocol DefaultRemoteImageServiceDependenciesProtocol: PhotoKitServiceProvider, RemoteImageURLDataPublisherProvider {
    
}

struct DefaultRemoteImageServiceDependencies: DefaultRemoteImageServiceDependenciesProtocol {
    let photoKitService: PhotoKitServiceProtocol
    let remoteImageURLDataPublisher: RemoteImageURLDataPublisher
    
    init(remoteImageURLDataPublisher: RemoteImageURLDataPublisher) {
        photoKitService = PhotoKitService()
        self.remoteImageURLDataPublisher = remoteImageURLDataPublisher
    }
}
