import ArgumentParser
import SwiftyGPIO
import Shared

public struct P13_1_1_Motor: ParsableCommand {
	public init() {
	}

	public static var configuration = CommandConfiguration(commandName: "13.1.1_Motor")

	public func run() throws {
		let gpio = GPIOs()
		let adc = try gpio.hardwareI2C(device: .new)

		var speedPin = try gpio.softwarePulseWidthModulation(for: .P27)
		let motorPins = [
			try gpio.named(.P17),
			try gpio.named(.P22),
		]

		for pin in motorPins {
			pin.direction = .OUT
			pin.value = LOW
		}

		while true {
			let rawValue = adc.read(.a0)

			let value = Int(rawValue) - 128

			if value > 0 {
				motorPins[0].value = HIGH
				motorPins[1].value = LOW
				print("Motor goes forward")
			} else if value < 0 {
				motorPins[0].value = LOW
				motorPins[1].value = HIGH
				print("Motor goes back")
			} else {
				motorPins[0].value = LOW
				motorPins[1].value = LOW
				print("Stopping motor")
			}

			let duty = 100 * Float(abs(value)) / 128
			speedPin.duty = duty
			print("Speed is \(duty)")

			sleep(Hz: 10)
		}
	}
}
