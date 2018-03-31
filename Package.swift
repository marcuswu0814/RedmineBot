// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RedmineBot",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
        .package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
        .package(url: "https://github.com/kylef/Stencil", .branch("master"))
    ],
    targets: [
        .target(
            name: "RedmineBot",
            dependencies: ["Alamofire", "Rainbow", "Commander", "Stencil"])
    ]
)