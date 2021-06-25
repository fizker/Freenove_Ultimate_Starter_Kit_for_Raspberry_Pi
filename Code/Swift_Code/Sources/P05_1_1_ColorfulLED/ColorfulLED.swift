import ArgumentParser
import Shared

struct ColorfulLED {
	let redLED: PulseWidthModulation
	let greenLED: PulseWidthModulation
	let blueLED: PulseWidthModulation
}

public struct P05_1_1_ColorfulLED: ParsableCommand {
	public init() {

	}

	public static var configuration = CommandConfiguration(commandName: "05.1.1_ColorfulLED")

	public func run() throws {
		print("Starting")

		let gpio = GPIOs()

		var red = try gpio.softwarePulseWidthModulation(for: .P17)
		var green = try gpio.softwarePulseWidthModulation(for: .P18)
		var blue = try gpio.softwarePulseWidthModulation(for: .P27)

		let range = Array(0..<100).map(Float.init)
		while(true) {
			red.duty = range.randomElement() ?? 0
			green.duty = range.randomElement() ?? 0
			blue.duty = range.randomElement() ?? 0

			print("R: \(red.duty)%, G: \(green.duty)%, B: \(blue.duty)%")

			sleep(s: 1)
		}
	}
}
