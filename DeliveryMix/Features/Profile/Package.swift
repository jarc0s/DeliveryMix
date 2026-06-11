// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Profile",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Profile", targets: ["Profile"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "Profile",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
