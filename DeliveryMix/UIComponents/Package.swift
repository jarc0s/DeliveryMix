// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "UIComponents",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "UIComponents", targets: ["UIComponents"]),
    ],
    targets: [
        .target(
            name: "UIComponents",
            path: "Sources"
        ),
    ]
)
