// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CanvasKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(name: "CanvasKit", targets: ["CanvasKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CanvasKit", dependencies: []),
        .testTarget(name: "CanvasKitTests", dependencies: ["CanvasKit"])
    ]
)
