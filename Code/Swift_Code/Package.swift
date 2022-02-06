// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Freenove_Kit",
	platforms: [
		.macOS(.v10_12),
	],
	products: [
		.executable(
			name: "Freenove_Kit",
			targets: ["cli"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.3"),
		.package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.3.9"),
		.package(url: "https://github.com/fizker/swift-gpio.git", from: "0.1.2"),
	],
	targets: [
		.target(
			name: "cli",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"P00_0_0_Hello",
				"P01_1_1_Blink",
				"P02_1_1_ButtonLED",
				"P03_1_1_LightWater",
				"P04_1_1_BreathingLED",
				"P05_1_1_ColorfulLED",
				"P07_1_1_ADC",
				"P15_1_1_Sweep",
				"P17_1_1_LightWater02",
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
			name: "P03_1_1_LightWater",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "P04_1_1_BreathingLED",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "P05_1_1_ColorfulLED",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "P07_1_1_ADC",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "P15_1_1_Sweep",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "P17_1_1_LightWater02",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Shared",
			]
		),
		.target(
			name: "Shared",
			dependencies: [
				.product(name: "SwiftGPIO", package: "swift-gpio"),
				"SwiftyGPIO",
			]
		)
	]
)
