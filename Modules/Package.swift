// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
        
        // Domain level modules
        .library(name: "ModuleA", targets: ["ModuleA"]),
        .library(name: "ModuleB", targets: ["ModuleB"]),
        
        // Core level modules
        .library(name: "MyService", targets: ["MyService"]),
        .library(name: "MyServiceLive", targets: ["MyServiceLive"]),
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.5.6")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Core"),
        .target(
            name: "MyService"
        ),
        .target(
            name: "MyServiceLive",
            dependencies: ["MyService"]
        ),
        .target(
            name: "ModuleA",
            dependencies: ["MyService", "Core"]
        ),
        .target(
            name: "ModuleB",
            dependencies: ["MyService", "Core"]
        ),
    ]
)
