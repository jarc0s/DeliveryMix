import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Home", targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../../Core")
        .package(path: "../../UICComponents")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: ["Core", "UICComponents"],
            path: "Sources"
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"],
            path: "Tests"
        ),
    ]
)