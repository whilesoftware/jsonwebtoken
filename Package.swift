// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "jsonwebtoken",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "jsonwebtoken",
            targets: ["jsonwebtoken"]),
    ],
    dependencies: [
        .package(url: "https://github.com/whilesoftware/SwiftyJSON.git", from: "5.0.1"),
        .package(name: "Crypto", url: "https://github.com/vapor/open-crypto.git", from: "3.4.1"),
    ],
    targets: [
        .target(
            name: "jsonwebtoken",
            dependencies: [
                "Crypto",
                "SwiftyJSON"
            ]),
        .testTarget(
            name: "jsonwebtokenTests",
            dependencies: ["jsonwebtoken"]),
    ]
)
