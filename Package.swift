// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "AppleMobileDevice",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "AppleMobileDevice",
            targets: ["AppleMobileDevice"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "AppleMobileDevice", dependencies: ["libimobiledevice.c", "AnyCodable"]),
        .target(name: "AnyCodable"),
        .binaryTarget(
            name: "libimobiledevice.c",
            url: "https://github.com/Lakr233/AppleMobileDevice/releases/download/1.0-6fc41f5/libimobiledevice.xcframework.zip",
            checksum: "4ccde64a2ac88087ab30aa0901a72d07b9323618d9c4523003de440af5a30f45"
        ),
    ]
)
