// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Timepiece",
    targets: [
        .target(name: "Timepiece"),
        .testTarget(
            name: "TimepieceTests",
            dependencies: ["Timepiece"]
        )
    ]
)
