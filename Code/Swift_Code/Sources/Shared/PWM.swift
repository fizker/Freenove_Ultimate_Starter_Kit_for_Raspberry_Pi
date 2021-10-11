import SwiftGPIO
import SwiftyGPIO

class WeakWrap<T: AnyObject> {
	weak var value: T?

	init(_ value: T) {
		self.value = value
	}
}

public enum PulseWidthModulationError: Error {
	case notFound
	case inUse
}

public class PulseWidthModulationHandler {
	let hardwarePWMs: [Int: [GPIOName: PWMOutput]]
	var channelsInUse: [Int: WeakWrap<HardwarePulseWidthModulation>] = [:]

	init?(board: SupportedBoard) {
		guard let hardwarePWMs = SwiftyGPIO.hardwarePWMs(for: board)
		else { return nil }

		self.hardwarePWMs = hardwarePWMs
	}

	public func pwm(named name: GPIOName) throws -> PulseWidthModulation {
		for (idx, col) in hardwarePWMs {
			if let output = col[name] {
				if let current = channelsInUse[idx] {
					if current.value == nil {
						channelsInUse[idx] = nil
					} else {
						throw PulseWidthModulationError.inUse
					}
				}

				let pwm = HardwarePulseWidthModulation(output)
				channelsInUse[idx] = .init(pwm)

				return pwm
			}
		}

		throw PulseWidthModulationError.notFound
	}
}

public class HardwarePulseWidthModulation: PulseWidthModulation {
	let output: PWMOutput
	public var duty: Float = 0 {
		didSet {
			output.startPWM(period: 2_000_000, duty: duty)
		}
	}

	init(_ pwm: PWMOutput) {
		self.output = pwm
		output.initPWM()
	}

	deinit {
		output.stopPWM()
	}
}
