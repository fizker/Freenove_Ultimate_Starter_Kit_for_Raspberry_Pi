import SwiftyGPIO

public enum I2CError: Error {
	case notFound, notReachable
}

public class I2C {
	public enum Device {
		case old, new
	}

	public enum Pin {
		case a0, a1, a2, a3, a4, a5, a6, a7

		var rawValue: UInt8 {
			switch self {
			case .a0: return 0
			case .a1: return 1
			case .a2: return 2
			case .a3: return 3
			case .a4: return 4
			case .a5: return 5
			case .a6: return 6
			case .a7: return 7
			}
		}
	}

	private static let addresses = [ 0x48, 0x4b ]
	private let i2c: I2CInterface

	let address: Int

	init(board: SupportedBoard, device: Device) throws {
		let pin: Int
		switch device {
		case .old: pin = 0
		case .new: pin = 1
		}

		guard let i2cs = SwiftyGPIO.hardwareI2Cs(for: board)
		else { throw I2CError.notFound }

		let i2c = i2cs[pin]

		guard let address = I2C.addresses.first(where: { i2c.isReachable($0) })
		else { throw I2CError.notReachable }

		self.i2c = i2c
		self.address = address
	}

	public func read(_ pin: Pin) -> UInt8 {
		return i2c.readByte(address, command: pin.rawValue)
	}
}
