// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "StoreDetail",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "StoreDetail", targets: ["StoreDetail"]),
    ],
    dependencies: [
        .package(path: "../../Core"),
        .package(path: "../../UIComponents"),
    ],
    targets: [
        .target(
            name: "StoreDetail",
            dependencies: ["Core", "UIComponents"],
            path: "Sources"
        ),
    ]
)
