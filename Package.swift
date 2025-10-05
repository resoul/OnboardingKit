// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PreviewIntro",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "PreviewIntro",
            targets: ["PreviewIntro"]
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
            name: "PreviewIntro",
            dependencies: [
                .product(name: "AsyncDisplayKit", package: "AsyncDisplayKit")
            ]
        ),
    ]
)
