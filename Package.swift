// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BetterLabel",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(name: "BetterLabel", targets: ["BetterLabel"]),
    ],
    targets: [
        .target(name: "BetterLabel", path: "BetterLabel")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
