//
//  RemoteImageServiceDependencies.swift
//  
//
//  Created by Christian Elies on 29.10.19.
//

import Foundation

protocol RemoteImageServiceDependenciesProtocol: PhotoKitServiceProvider, RemoteImageURLDataPublisherProvider {
    
}

struct RemoteImageServiceDependencies: RemoteImageServiceDependenciesProtocol {
    let photoKitService: PhotoKitServiceProtocol
    let remoteImageURLDataPublisher: RemoteImageURLDataPublisher
    
    init() {
        photoKitService = PhotoKitService()
        remoteImageURLDataPublisher = URLSession.shared
    }
}
