// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "Ethernet",
        platforms: [
            .macOS(.v10_15), .iOS(.v13)
        ],
        products: [
            // Products define the executables and libraries a package produces, making them visible to other packages.
            .library(
                    name: "Ethernet",
                    targets: ["Ethernet"]),
        ],
        dependencies: [
            // Dependencies declare other packages that this package depends on.
            .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
            .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
        ],
        targets: [
            // Targets are the basic building blocks of a package, defining a module or a test suite.
            // Targets can depend on other targets in this package and products from dependencies.
            .target(
                    name: "Ethernet",
                    dependencies: [.product(name: "NIO", package: "swift-nio"),
                                   .product(name: "Logging", package: "swift-log")]),

            .testTarget(
                    name: "EthernetTests",
                    dependencies: ["Ethernet"]),
        ]
)
