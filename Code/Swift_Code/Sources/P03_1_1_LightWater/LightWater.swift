import ArgumentParser
import SwiftGPIO
import Shared

public struct P03_1_1_LightWater: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "03.1.1_LightWater")

	public mutating func run() throws {
		let controller = GPIOs()
		let pins: [GPIO.Pin] = [
			.p17, // C:0
			.p18, // C:1
			.p27, // C:2
			.p22, // C:3
			.p23, // C:4
			.p24, // C:5
			.p25, // C:6
			.p12, // C:8 (substitute)
			.p16, // C:9 (substitute)
			.p20, // C:10 (substitute)
		]
		let gpios = try pins.map { try controller.gpio(pin: $0, direction: .out, value: .on) }

		func flip(pin: GPIO) {
			// Because of the wiring, turning the pin off actually turns the light on
			// This is because the pin being off makes it act like ground
			pin.value = .off
			sleep(ms: 100)
			pin.value = .on
		}

		while true {
			gpios.forEach(flip(pin:))
			gpios.reversed().forEach(flip(pin:))
		}
	}
}
