// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ohce-kata",
    dependencies: [],
    targets: [
        .executableTarget(name: "ohce", dependencies: []),
        .testTarget(name: "ohceTests", dependencies: ["ohce"])
    ]
)
