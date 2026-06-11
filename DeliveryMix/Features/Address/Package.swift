// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Address",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Address", targets: ["Address"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "Address",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
