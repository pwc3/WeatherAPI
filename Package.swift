// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherAPI",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WeatherAPI",
            targets: ["WeatherAPI"]),
        .library(
            name: "SampleWeatherData",
            targets: ["SampleWeatherData"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WeatherAPI",
            dependencies: []),
        .target(
            name: "SampleWeatherData",
            dependencies: ["WeatherAPI"]),
        .testTarget(
            name: "WeatherAPITests",
            dependencies: ["WeatherAPI", "SampleWeatherData"]),
    ]
)
