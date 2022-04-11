//
//  ContentView.swift
//  RemoteImage
//
//  Created by Christian Elies on 11.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import RemoteImage
import SwiftUI

struct ContentView: View {
    private let url = URL(string: "https://images.unsplash.com/photo-1524419986249-348e8fa6ad4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")!
    
    var body: some View {
        RemoteImage(type: .url(url), errorView: { error in
            Text(error.localizedDescription)
        }, imageView: { image in
            image
            .resizable()
            .aspectRatio(contentMode: .fit)
        }, loadingView: {
            ProgressView()
        })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
