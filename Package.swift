// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Newsshield",
    products: [
        .executable(name: "Newsshield", targets: ["Newsshield"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "Newsshield",
            dependencies: ["Publish"]
        )
    ]
)