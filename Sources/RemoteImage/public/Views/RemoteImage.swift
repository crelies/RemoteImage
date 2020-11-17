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

public struct RemoteImage<ErrorView: View, ImageView: View, LoadingView: View>: View {
    private let type: RemoteImageType
    private let errorView: (Error) -> ErrorView
    private let imageView: (Image) -> ImageView
    private let loadingView: () -> LoadingView

    @ObservedObject private var service: RemoteImageService

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

    public init(type: RemoteImageType, remoteImageURLDataPublisher: RemoteImageURLDataPublisher = URLSession.shared, @ViewBuilder errorView: @escaping (Error) -> ErrorView, @ViewBuilder imageView: @escaping (Image) -> ImageView, @ViewBuilder loadingView: @escaping () -> LoadingView) {
        self.type = type
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView

        let service = RemoteImageServiceFactory.makeRemoteImageService(remoteImageURLDataPublisher: remoteImageURLDataPublisher)
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
