// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Checkout",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Checkout", targets: ["Checkout"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "Checkout",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
