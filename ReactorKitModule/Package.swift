// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReactorKitModule",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ReactorKitModule",
            targets: ["ReactorKitModule"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "./Network"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.2.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ReactorKitModule",
            dependencies: [
                .product(name: "Network", package: "Network"),
                "ReactorKit",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift")
        ]),
        .testTarget(
            name: "ReactorKitModuleTests",
            dependencies: [
                .product(name: "Network", package: "Network")
            ]),
    ]
)
