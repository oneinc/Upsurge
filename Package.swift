// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Upsurge",
    products: [
        .library(
            name: "Upsurge",
            targets: ["Upsurge"]
        ),
    ],
    targets: [
        .target(
            name: "Upsurge",
            dependencies: []
        ),
        .testTarget(
            name: "UpsurgeTests",
            dependencies: ["Upsurge"]
        ),
    ]
)
