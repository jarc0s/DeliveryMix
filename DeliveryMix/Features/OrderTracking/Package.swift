// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "OrderTracking",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "OrderTracking", targets: ["OrderTracking"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "OrderTracking",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
