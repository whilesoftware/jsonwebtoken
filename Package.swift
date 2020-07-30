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
        .package(url: "https://github.com/whilesoftware/SwiftyJSON.git", .revision("7080c04af17ca65802a2c4511f64fe12f851ed61"))
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
