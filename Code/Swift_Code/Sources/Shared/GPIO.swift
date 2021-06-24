import SwiftyGPIO

enum GPIOError: Error {
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
}
