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
        .package(url: "https://github.com/Apodini/Apodini.git", .revision("251bbba60b1023443b6973d80ba42c4155fe143a")),
        .package(name: "Shared", path: "../Shared")
    ],
    targets: [
        .executableTarget(
            name: "WebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "XpenseModel", package: "Shared")
            ]
        )
    ]
)
