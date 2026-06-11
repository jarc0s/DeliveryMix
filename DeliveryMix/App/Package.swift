// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "DeliveryMix",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Features/Auth"),
        .package(path: "../Features/Home"),
        .package(path: "../Features/StoreDetail"),
        .package(path: "../Features/Cart"),
        .package(path: "../Features/Address"),
        .package(path: "../Features/Checkout"),
        .package(path: "../Features/OrderTracking"),
        .package(path: "../Features/Profile"),
        .package(path: "../UIComponents"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "Core", "Auth", "Home", "StoreDetail", "Cart",
                "Address", "Checkout", "OrderTracking", "Profile", "UIComponents"
            ],
            path: "Sources",
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
