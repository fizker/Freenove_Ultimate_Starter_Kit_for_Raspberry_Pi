import SwiftyGPIO

enum GPIOError: Error {
	case gpioNotFound
}

public struct GPIOs {
	public init() {
		self.gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi3)
	}

	let gpios: [GPIOName: GPIO]
	public func named(_ name: GPIOName) throws -> GPIO {
		guard let gpio = gpios[name]
		else { throw GPIOError.gpioNotFound }

		return gpio
	}
}
