//
//  RemoteImage.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import SwiftUI

public struct RemoteImage<ErrorView: View, ImageView: View, LoadingView: View>: View {
    private let type: RemoteImageType
    private let errorView: (Error) -> ErrorView
    private let imageView: (Image) -> ImageView
    private let loadingView: () -> LoadingView

    @ObservedObject private var service = RemoteImageServiceFactory.makeRemoteImageService()

    public var body: AnyView {
        switch service.state {
            case .error(let error):
                return AnyView(
                    errorView(error)
                )
            case .image(let image):
                #if canImport(UIKit)
                    return AnyView(
                        self.imageView(Image(uiImage: image))
                    )
                #elseif os(macOS)
                    return AnyView(
                        self.imageView(Image(nsImage: image))
                    )
                #else
                    return AnyView(
                        Text("Cannot render image: unsupported platform")
                    )
                #endif
            case .loading:
                return AnyView(
                    loadingView()
                )
        }
    }

    public init(type: RemoteImageType, @ViewBuilder errorView: @escaping (Error) -> ErrorView, @ViewBuilder imageView: @escaping (Image) -> ImageView, @ViewBuilder loadingView: @escaping () -> LoadingView) {
        self.type = type
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView

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
