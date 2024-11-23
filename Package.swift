// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "swift-app-library",
  platforms: [
    .iOS(.v18),
    .macOS(.v15),
    .tvOS(.v18),
    .watchOS(.v11),
  ],
  products: [
    .library(
      name: "AppLibrary",
      targets: ["AppLibrary"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "1.5.4"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.2"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-macro-testing", from: "0.2.0"),
    .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.2.2"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.3.0"),
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    // .package(url: "https://github.com/swiftlang/swift-syntax", "509.0.0"..<"601.0.0-prerelease"),
  ],
  targets: [
    .target(
      name: "AppLibrary",
      dependencies: [
        .product(name: "CasePaths", package: "swift-case-paths"),
        .product(name: "CustomDump", package: "swift-custom-dump"),
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
        .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
        .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
        .product(name: "OrderedCollections", package: "swift-collections"),
        .product(name: "SwiftUINavigation", package: "swift-navigation"),
        .product(name: "UIKitNavigation", package: "swift-navigation"),
        .product(name: "AppKitNavigation", package: "swift-navigation"),
      ],
      resources: [
        .process("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .testTarget(
      name: "AppLibraryTests",
      dependencies: [
        "AppLibrary",
        .product(name: "IssueReportingTestSupport", package: "xctest-dynamic-overlay"),
      ]
    ),
    // .macro(
    //   name: "AppLibraryMacros",
    //   dependencies: [
    //     .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
    //     .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
    //   ]
    // ),
    // .testTarget(
    //   name: "AppLibraryMacrosTests",
    //   dependencies: [
    //     "AppLibraryMacros",
    //     .product(name: "MacroTesting", package: "swift-macro-testing"),
    //   ]
    // ),
  ],
  swiftLanguageModes: [.v6]
)

for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(contentsOf: [
    .enableUpcomingFeature("ExistentialAny")
  ])
}

for target in package.targets where target.type == .system || target.type == .test {
  target.swiftSettings?.append(contentsOf: [
    .swiftLanguageMode(.v5),
    .enableExperimentalFeature("StrictConcurrency"),
    .enableUpcomingFeature("InferSendableFromCaptures"),
  ])
}
