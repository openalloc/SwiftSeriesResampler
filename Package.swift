// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftSeriesResampler",
    // platforms: [.macOS(.v10_15)], // needed for Date.distance(to:) support
    platforms: [.macOS(.v11)], // needed for vDSP.linearInterpolate() support
    products: [
        .library(name: "SeriesResampler", targets: ["SeriesResampler"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SeriesResampler",
            dependencies: [
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "SeriesResamplerTests",
            dependencies: ["SeriesResampler"],
            path: "Tests"
        ),
    ]
)
