// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "jsonwebtoken",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v10_14)
    ],
    products: [
        .library(
            name: "jsonwebtoken",
            targets: ["jsonwebtoken"]),
    ],
    dependencies: [
        //.package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0")
        .package(url: "https://github.com/whilesoftware/SwiftyJSON.git", from: "5.0.0-patched")
    ],
    targets: [
        .target(
            name: "jsonwebtoken",
            dependencies: [
                "SwiftyJSON"
            ]),
        .testTarget(
            name: "jsonwebtokenTests",
            dependencies: ["jsonwebtoken"]),
    ]
)
