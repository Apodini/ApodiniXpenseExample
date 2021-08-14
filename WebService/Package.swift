// swift-tools-version:5.5

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
        .package(url: "https://github.com/Apodini/Apodini.git", .revision("d68e398166acc43308fecd5ed0529a7bca66dc9e")),
        .package(name: "Shared", path: "../Shared")
    ],
    targets: [
        .executableTarget(
            name: "WebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniAuthorization", package: "Apodini"),
                .product(name: "ApodiniAuthorizationBasicScheme", package: "Apodini"),
                .product(name: "ApodiniAuthorizationBearerScheme", package: "Apodini"),
                .product(name: "XpenseModel", package: "Shared")
            ]
        )
    ]
)
