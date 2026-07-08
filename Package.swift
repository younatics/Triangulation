// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Triangulation",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Triangulation", targets: ["Triangulation"])
    ],
    targets: [
        .target(
            name: "Triangulation",
            path: "Triangulation",
            exclude: [
                "Triangulation.h",
                "Info.plist"
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "TriangulationTests",
            dependencies: ["Triangulation"],
            path: "Tests/TriangulationTests",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        )
    ]
)
