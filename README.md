# RemoteImage

[![Swift 5.1](https://img.shields.io/badge/swift-5.1-green.svg?longCache=true&style=flat-square)](https://developer.apple.com/swift)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS-lightgrey.svg?longCache=true&style=flat-square)](https://www.apple.com)
[![Current Version](https://img.shields.io/github/v/tag/crelies/RemoteImage?longCache=true&style=flat-square)](https://github.com/crelies/RemoteImage)
[![Build status](https://travis-ci.com/crelies/RemoteImage.svg?token=THnaziKxRFFz1nKcsPgz&branch=dev)](https://travis-ci.com/crelies/RemoteImage)
[![Code coverage](https://codecov.io/gh/crelies/RemoteImage/branch/dev/graph/badge.svg?token=DhJyoUKNPM)](https://codecov.io/gh/crelies/RemoteImage)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?longCache=true&style=flat-square)](https://en.wikipedia.org/wiki/MIT_License)

This Swift package provides a wrapper view around the existing **SwiftUI** `Image view` which adds support for showing and caching remote images.
In addition you can specify a loading and error view.

You can display images from a specific **URL** or from the **iCloud** (through a `PHAsset` identifier).

## 💡 Installation

Add this Swift package in Xcode using its Github repository url. (File > Swift Packages > Add Package Dependency...)

## 🧭 How to use

Just pass a remote image url or the local identifier of a `PHAsset` and `ViewBuilder`s for the error, image and loading state to the initializer. That's it 🎉

Clear the image cache through `RemoteImageService.cache.removeAllObjects()`.

## 📖 Examples

The following code truly highlights the **simplicity** of this view:

**URL example:**
```swift
let url = URL(string: "https://images.unsplash.com/photo-1524419986249-348e8fa6ad4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")!

RemoteImage(type: .url(url), errorView: { error in
    Text(error.localizedDescription)
}, imageView: { image in
    image
    .resizable()
    .aspectRatio(contentMode: .fit)
}, loadingView: {
    Text("Loading ...")
})
```

**PHAsset example:**
```swift

RemoteImage(type: .phAsset(localIdentifier: "541D4013-D51C-463C-AD85-0A1E4EA838FD"), errorView: { error in
    Text(error.localizedDescription)
}, imageView: { image in
    image
    .resizable()
    .aspectRatio(contentMode: .fit)
}, loadingView: {
    Text("Loading ...")
})
```

## Custom cache

The `RemoteImageService` uses a default cache. To use a custom one just conform to the protocol `RemoteImageCache` and set it on the type `RemoteImageService`.

```swift
RemoteImageService.cache = yourCache
```

## Custom cache key

The default cache uses the associated value of the related `RemoteImageType` as the key. You can customize this by setting a cache key provider through

```swift
RemoteImageService.cacheKeyProvider = { remoteImageType -> AnyObject in
    // return a key here
}
```

## Migration from 0.1.0 -> 1.0.0

The `url parameter` was refactored to a `type parameter` which makes it easy to fetch images at a URL or from the iCloud. 

Change
```swift
# Version 0.1.0
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

to
```swift
# Version 1.0.0
let url = URL(string: "https://images.unsplash.com/photo-1524419986249-348e8fa6ad4a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")!

RemoteImage(type: .url(url), errorView: { error in
    Text(error.localizedDescription)
}, imageView: { image in
    image
    .resizable()
    .aspectRatio(contentMode: .fit)
}, loadingView: {
    Text("Loading ...")
})
```
