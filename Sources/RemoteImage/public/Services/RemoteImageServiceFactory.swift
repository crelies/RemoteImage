//
//  RemoteImageServiceFactory.swift
//  RemoteImage
//
//  Created by Christian Elies on 29.10.19.
//

public final class RemoteImageServiceFactory {
    public static func makeRemoteImageService(remoteImageURLDataPublisher: RemoteImageURLDataPublisher) -> RemoteImageService {
        let dependencies = RemoteImageServiceDependencies(remoteImageURLDataPublisher: remoteImageURLDataPublisher)
        return RemoteImageService(dependencies: dependencies)
    }
}
