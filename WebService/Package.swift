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
    name: "WebService",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "WebService", targets: ["WebService"])
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .branch("lukaskollmer/fix-lambda-integration")),
        .package(name: "Shared", path: "../Shared")
    ],
    targets: [
        .executableTarget(
            name: "WebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniAuthorization", package: "Apodini"),
                .product(name: "ApodiniAuthorizationBasicScheme", package: "Apodini"),
                .product(name: "ApodiniAuthorizationBearerScheme", package: "Apodini"),
                .product(name: "ApodiniDeploy", package: "Apodini"),
                .product(name: "DeploymentTargetLocalhostRuntime", package: "Apodini"),
                .product(name: "DeploymentTargetAWSLambdaRuntime", package: "Apodini"),
                .product(name: "XpenseModel", package: "Shared")
            ]
        )
    ]
)
