// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "OnboardingKit",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "OnboardingKit",
            targets: ["OnboardingKit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/resoul/AsyncDisplayKit.git",
            exact: "3.2.0"
        ),
    ],
    targets: [
        .target(
            name: "OnboardingKit",
            dependencies: [
                .product(name: "AsyncDisplayKit", package: "AsyncDisplayKit")
            ]
        ),
        .testTarget(
            name: "OnboardingKitTests",
            dependencies: ["OnboardingKit", "AsyncDisplayKit"]
        )
    ]
)
