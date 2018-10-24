// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Timepiece",
    products: [
        .library(name: "Timepiece", targets: ["Timepiece"]),
    ],
    targets: [
        .target(name: "Timepiece"),
        .testTarget(
            name: "TimepieceTests",
            dependencies: ["Timepiece"]
        )
    ]
)
