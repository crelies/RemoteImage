//
//  DefaultRemoteImageServiceFactory.swift
//  RemoteImage
//
//  Created by Christian Elies on 29.10.19.
//

public final class DefaultRemoteImageServiceFactory {
    public static func makeDefaultRemoteImageService(remoteImageURLDataPublisher: RemoteImageURLDataPublisher) -> DefaultRemoteImageService {
        let dependencies = DefaultRemoteImageServiceDependencies(remoteImageURLDataPublisher: remoteImageURLDataPublisher)
        return DefaultRemoteImageService(dependencies: dependencies)
    }
}
