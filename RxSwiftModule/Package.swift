// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxSwiftModule",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RxSwiftModule",
            targets: ["RxSwiftModule"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "./Network"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RxSwiftModule",
            dependencies: [
                .product(name: "Network", package: "Network"),
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift")
        ]),
        .testTarget(
            name: "RxSwiftModuleTests",
            dependencies: [
                .product(name: "Network", package: "Network")
            ]),
    ]
)
