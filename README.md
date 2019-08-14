# RemoteImage

[![Swift5](https://img.shields.io/badge/swift5-compatible-green.svg?longCache=true&style=flat-square)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg?longCache=true&style=flat-square)](https://www.apple.com/de/ios)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?longCache=true&style=flat-square)](https://en.wikipedia.org/wiki/MIT_License)

This Swift package provides a wrapper view around the existing **SwiftUI** `Image view` which adds support for showing and caching remote images.
In addition you can specify a loading and error view.

## Installation

Add this Swift package in Xcode using its Github repository url. (File > Swift Packages > Add Package Dependency...)

## How to use

Just pass your remote image url and `ViewBuilder`s for the error, image and loading state to the initializer. That's it 🎉

Clear the image cache through `RemoteImageService.cache.removeAllObjects()`.

## Example

The following code truly highlights the **simplicity** of this view:

```swift
let url = URL(string: "https://images.unsplash.com/photo-1524419986249-348e8fa6ad4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")!

RemoteImage(url: url, errorView: { error in
    Text(error.localizedDescription)
}, imageView: { image in
    image
    .resizable()
    .aspectRatio(contentMode: .fit)
}, loadingView: {
    Text("Loading ...")
})
```
