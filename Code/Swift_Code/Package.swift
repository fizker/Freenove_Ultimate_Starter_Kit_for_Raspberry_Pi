// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Freenove_Kit",
	products: [
		.executable(
			name: "Freenove_Kit",
			targets: ["cli"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.4.0")),
	],
	targets: [
		.target(
			name: "cli",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"P00_0_0_Hello",
			]
		),
		.target(
			name: "P00_0_0_Hello",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),
	]
)
