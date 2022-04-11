# RemoteImage-SwiftUI

Remote Image view with error and loading state for **SwiftUI**

This repository contains a usage example of my Swift package for a remote **SwiftUI** `Image view` to show remote images.
You can find the Swift package [here](https://github.com/crelies/RemoteImage).

## Motivation

I wanted to have a simple and extendable remote image view in **SwiftUI** which takes care of all the magic
(image loading, caching, error and loading view). At my current employer we used a custom **UIKit** view for that.

## Preview

![Animated preview image](https://github.com/crelies/RemoteImage-SwiftUI/blob/master/RemoteImage.gif)

Code:

```swift
let url = URL(string: "https://images.unsplash.com/photo-1524419986249-348e8fa6ad4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")!

RemoteImage(type: .url(url), errorView: { error in
    Text(error.localizedDescription)
}, image: { image in
    image
    .resizable()
    .aspectRatio(contentMode: .fit)
}, loadingView: {
    Text("Loading ...")
})
```
