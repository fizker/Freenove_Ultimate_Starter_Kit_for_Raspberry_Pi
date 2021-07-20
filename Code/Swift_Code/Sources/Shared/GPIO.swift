import SwiftyGPIO

let HIGH = 1
let LOW = 0

public enum GPIOError: Error {
	case gpioNotFound
}

public class GPIOs {
	public let board: SupportedBoard
	let gpios: [GPIOName: GPIO]
	public let pwm: PulseWidthModulationHandler?

	public init() {
		self.board = .RaspberryPi3
		self.gpios = SwiftyGPIO.GPIOs(for: board)
		self.pwm = .init(board: board)
	}

	public func named(_ name: GPIOName) throws -> GPIO {
		guard let gpio = gpios[name]
		else { throw GPIOError.gpioNotFound }

		return gpio
	}

	public func hardwareI2C(pin: Int) throws -> I2C {
		return try I2C(board: board, pin: pin)
	}
}
