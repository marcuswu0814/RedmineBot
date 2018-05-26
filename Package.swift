// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RedmineBot",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/SwiftyRequest.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/IBM-Swift/swift-html-entities", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/marcuswu0814/SwiftCLIToolbox", .branch("master"))
    ],
    targets: [
        .target(
            name: "RedmineBot",
            dependencies: ["RedmineBotCore"]),
        .target(
            name: "RedmineBotCore",
            dependencies: ["SwiftyRequest", "HTMLEntities", "SwiftCLIToolbox"]),
        .testTarget(
            name: "RedmineBotTest",
            dependencies: ["RedmineBotCore"])
    ]
)
