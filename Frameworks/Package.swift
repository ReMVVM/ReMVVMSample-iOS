// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Frameworks",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Frameworks",
            type: .dynamic,
            targets: ["Frameworks"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
//        .package(name: "ReMVVMExt", path: "../../ReMVVMExt"),
//        .package(name: "ReMVVM", path: "../../ReMVVM"),
//        .package(name: "ReMVVMRxSwift", path: "../../ReMVVMRxSwift"),
        .package(
            name: "ReMVVMExt",
            url: "https://github.com/ReMVVM/ReMVVMExtUIKit",
            .upToNextMajor(from: "3.0.0")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Frameworks",
            dependencies: [
                "ReMVVMExt"
            ]),
        .testTarget(
            name: "FrameworksTests",
            dependencies: ["Frameworks"]),
    ]
)
