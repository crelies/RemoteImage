//
//  RemoteImage.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

#if canImport(SwiftUI)
import Combine
import SwiftUI

/// A custom Image view for remote images with support for a loading and error state.
public struct RemoteImage<ErrorView: View, ImageView: View, LoadingView: View, Service: RemoteImageService>: View {
    private let type: RemoteImageType
    private let errorView: (Error) -> ErrorView
    private let imageView: (Image) -> ImageView
    private let loadingView: () -> LoadingView

    @ObservedObject private var service: Service

    public var body: some View {
        switch service.state {
        case .loading:
            loadingView()
        case let .error(error):
            errorView(error)
        case let .image(uiImage):
            #if os(macOS)
            imageView(Image(nsImage: uiImage))
            #elseif os(iOS)
            imageView(Image(uiImage: uiImage))
            #endif
        }
    }

    /// Initializes the view with the given values, especially with a custom `RemoteImageService`.
    ///
    /// - Parameters:
    ///   - type: Specifies the source type of the remote image. Choose between `.url` or `.phAsset`.
    ///   - service: An object conforming to the `RemoteImageService` protocol. Responsible for fetching the image and managing the state.
    ///   - errorView: A view builder used to create the view displayed in the error state.
    ///   - imageView: A view builder used to create the `Image` displayed in the image state.
    ///   - loadingView: A view builder used to create the view displayed in the loading state.
    public init(type: RemoteImageType, service: Service, @ViewBuilder errorView: @escaping (Error) -> ErrorView, @ViewBuilder imageView: @escaping (Image) -> ImageView, @ViewBuilder loadingView: @escaping () -> LoadingView) {
        self.type = type
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView
        _service = ObservedObject(wrappedValue: service)

        service.fetchImage(ofType: type)
    }
}

extension RemoteImage where Service == DefaultRemoteImageService {
    /// Initializes the view with the given values. Uses the built-in `DefaultRemoteImageService`.
    ///
    /// - Parameters:
    ///   - type: Specifies the source type of the remote image. Choose between `.url` or `.phAsset`.
    ///   - remoteImageURLDataPublisher: An object conforming to the `RemoteImageURLDataPublisher` protocol, by default `URLSession.shared` is used.
    ///   - errorView: A view builder used to create the view displayed in the error state.
    ///   - imageView: A view builder used to create the `Image` displayed in the image state.
    ///   - loadingView: A view builder used to create the view displayed in the loading state.
    public init(type: RemoteImageType, remoteImageURLDataPublisher: RemoteImageURLDataPublisher = URLSession.shared, @ViewBuilder errorView: @escaping (Error) -> ErrorView, @ViewBuilder imageView: @escaping (Image) -> ImageView, @ViewBuilder loadingView: @escaping () -> LoadingView) {
        self.type = type
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView

        let service = DefaultRemoteImageServiceFactory.makeDefaultRemoteImageService(remoteImageURLDataPublisher: remoteImageURLDataPublisher)
        _service = ObservedObject(wrappedValue: service)

        service.fetchImage(ofType: type)
    }
}

#if DEBUG
struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://images.unsplash.com/photo-1524419986249-348e8fa6ad4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")!
        return RemoteImage(type: .url(url), errorView: { error in
            Text(error.localizedDescription)
        }, imageView: { image in
            image
        }, loadingView: {
            Text("Loading ...")
        })
    }
}
#endif

#endif
