import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Core", targets: ["Core"]),
    ],
    dependencies:[
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.25.0"),
    ]
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"],
            path: "Tests"
        ),
    ]
)