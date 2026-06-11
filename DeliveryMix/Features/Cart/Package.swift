// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Cart",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Cart", targets: ["Cart"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "Cart",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
