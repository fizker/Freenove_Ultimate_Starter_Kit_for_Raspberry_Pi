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
		.package(url: "https://github.com/uraimo/SwiftyGPIO.git", .upToNextMajor(from: "1.3.5")),
	],
	targets: [
		.target(
			name: "cli",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"P00_0_0_Hello",
				"P01_1_1_Blink",
				"P02_1_1_ButtonLED",
			]
		),
		.target(
			name: "P00_0_0_Hello",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),
		.target(
			name: "P01_1_1_Blink",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "P02_1_1_ButtonLED",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "Shared",
			dependencies: [
				"SwiftyGPIO",
			]
		)
	]
)
