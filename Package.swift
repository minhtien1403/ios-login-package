// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginFeature",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "LoginFeature", targets: ["LoginFeature"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/minhtien1403/ios-shared-package",
            branch: "master"
        ),
        .package(
            url: "https://github.com/minhtien1403/ios-core-package",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "LoginFeature",
            dependencies: [
                .product(name: "Shared", package: "ios-shared-package"),
                .product(name: "Core", package: "ios-core-package"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "LoginFeatureTests",
            dependencies: ["LoginFeature"]
        )
    ]
)
