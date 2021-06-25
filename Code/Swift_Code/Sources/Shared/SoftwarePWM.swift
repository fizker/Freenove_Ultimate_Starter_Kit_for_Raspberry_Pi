import Foundation
import SwiftyGPIO

class SoftwarePulseWidthModulation: PulseWidthModulation {
	public var duty: Float

	let pin: GPIO
	let range: UInt32
	var thread: Thread?

	init(pin: GPIO, duty: Float = 0, range: UInt32 = 100) {
		self.pin = pin
		pin.direction = .OUT
		pin.value = LOW

		self.duty = duty
		self.range = range

		self.thread = nil

		thread = .init(block: run)
		thread?.start()
	}

	deinit {
		pin.value = LOW
		duty = 0
	}

	func run() {
		while(true) {
			let mark = UInt32(duty)
			let space = range - mark

			if mark != 0 {
				pin.value = HIGH
				sleep(µs: mark * 100)
			}

			if space != 0 {
				pin.value = LOW
				sleep(µs: space * 100)
			}
		}
	}
}

public extension GPIOs {
	func softwarePulseWidthModulation(for pinName: GPIOName, duty: Float = 0, range: UInt32 = 100) throws -> PulseWidthModulation {
		let pin = try self.named(pinName)
		return SoftwarePulseWidthModulation(pin: pin, duty: duty, range: range)
	}
}
