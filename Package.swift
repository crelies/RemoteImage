// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteImage",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "RemoteImage",
            targets: ["RemoteImage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.3.8")
    ],
    targets: [
        .target(
            name: "RemoteImage",
            dependencies: []),
        .testTarget(
            name: "RemoteImageTests",
            dependencies: ["RemoteImage", "ViewInspector"]),
    ]
)
