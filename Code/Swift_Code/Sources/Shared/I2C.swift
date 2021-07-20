import SwiftyGPIO

public enum I2CError: Error {
	case notFound, notReachable
}

public class I2C {
	private static let addresses = [ 0x48, 0x4b ]
	private let i2c: I2CInterface

	let address: Int

	init(board: SupportedBoard, pin: Int) throws {
		guard
			let i2cs = SwiftyGPIO.hardwareI2Cs(for: board),
			i2cs.count > pin
		else { throw I2CError.notFound }

		let i2c = i2cs[pin]

		guard let address = I2C.addresses.first(where: { i2c.isReachable($0) })
		else { throw I2CError.notReachable }

		self.i2c = i2c
		self.address = address
	}

	public func read(pin: UInt8) -> UInt8 {
		return i2c.readByte(address, command: pin)
	}
}
