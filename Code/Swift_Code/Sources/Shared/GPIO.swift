import SwiftGPIO

extension GPIOController {
	public convenience init() {
		self.init(board: .raspberryPi3)
	}
}
