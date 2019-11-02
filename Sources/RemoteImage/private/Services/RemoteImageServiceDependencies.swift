//
//  RemoteImageServiceDependencies.swift
//  
//
//  Created by Christian Elies on 29.10.19.
//

import Foundation

protocol RemoteImageServiceDependenciesProtocol: PhotoKitServiceProvider {
    
}

struct RemoteImageServiceDependencies: RemoteImageServiceDependenciesProtocol {
    let photoKitService: PhotoKitServiceProtocol
    
    init() {
        photoKitService = PhotoKitService()
    }
}
