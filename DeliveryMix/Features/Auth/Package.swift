// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Auth",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Auth", targets: ["Auth"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "Auth",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
