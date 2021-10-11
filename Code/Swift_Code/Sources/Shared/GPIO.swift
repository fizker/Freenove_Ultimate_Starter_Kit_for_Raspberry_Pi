import SwiftGPIO
import SwiftyGPIO

extension GPIOs {
	public convenience init() {
		self.init(board: .raspberryPi3)
	}

	public func pwm() -> PulseWidthModulationHandler? {
		.init(board: self.board.swifty)
	}

	public func hardwareI2C(device: I2C.Device) throws -> I2C {
		return try I2C(board: board.swifty, device: device)
	}
}

extension Board {
	var swifty: SupportedBoard {
		switch self {
		case .raspberryPiRev1: return .RaspberryPiRev1
		case .raspberryPiRev2: return .RaspberryPiRev2
		case .raspberryPiPlusZero: return .RaspberryPiPlusZero
		case .raspberryPi2: return .RaspberryPi2
		case .raspberryPi3: return .RaspberryPi3
		case .raspberryPi4: return .RaspberryPi4
		case .chip: return .CHIP
		case .beagleBoneBlack: return .BeagleBoneBlack
		case .orangePi: return .OrangePi
		case .orangePiZero: return .OrangePiZero
		}
	}
}
