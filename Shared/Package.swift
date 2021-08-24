// swift-tools-version:5.5

//
// This source file is part of the Apodini Xpense Example open source project
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "Shared",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .executable(name: "xpense", targets: ["xpense"]),
        .library(name: "XpenseModel", targets: ["XpenseModel"]),
        .library(name: "RESTfulXpenseModel", targets: ["RESTfulXpenseModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.4"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.1.6")
    ],
    targets: [
        .executableTarget(
            name: "xpense",
            dependencies: [
                .target(name: "RESTfulXpenseModel"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "XpenseModel",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto")
            ]
        ),
        .target(
            name: "RESTfulXpenseModel",
            dependencies: [
                .target(name: "XpenseModel")
            ]
        )
    ]
)
