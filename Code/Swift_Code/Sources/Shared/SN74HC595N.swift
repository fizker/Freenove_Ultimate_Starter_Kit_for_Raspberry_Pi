import SwiftGPIO

public extension Array where Element: OptionSet {
	func combined() -> Element {
		self.reduce([]) {
			$0.union($1)
		}
	}
}

/// Controller class for the 74HC595N chip.
/// The chip converts serial data into parallel data. It has 3 inputs and 8 outputs, allowing the board to control 8 pins with 3.
public class SN74HC595N {
	public struct Output: OptionSet, Codable {
		enum BitsParsingError: Error {
			case invalidLength, invalidFormat
		}

		public typealias RawValue = Int

		public var rawValue: RawValue

		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}

		public init(bits: String) throws {
			if bits.count != 8 {
				throw BitsParsingError.invalidLength
			}

			var idx = 0
			let output = try bits.reversed().map {
				defer { idx += 1 }

				switch $0 {
				case "0": return 0
				case "1": break
				default: throw BitsParsingError.invalidFormat
				}

				return 1 << idx
			}.reduce(0, +)
			print("turned \(bits) (\(bits.reversed().map(String.init).joined(separator: ""))) into \(output)")
			rawValue = output
		}

		public static let output1: Self = .init(rawValue: 1 << 0)
		public static let output2: Self = .init(rawValue: 1 << 1)
		public static let output3: Self = .init(rawValue: 1 << 2)
		public static let output4: Self = .init(rawValue: 1 << 3)
		public static let output5: Self = .init(rawValue: 1 << 4)
		public static let output6: Self = .init(rawValue: 1 << 5)
		public static let output7: Self = .init(rawValue: 1 << 6)
		public static let output8: Self = .init(rawValue: 1 << 7)

		public static let allOutputs = [
			output1,
			output2,
			output3,
			output4,
			output5,
			output6,
			output7,
			output8,
		]
		public static var all: Output {
			allOutputs.combined()
		}

		public var bits: String {
			Self.allOutputs
				// we reverse the order to get the first bit in the end
				.reversed()
				// Flipping the presence into 1 or 0
				.map { contains($0) ? "1" : "0" }
				.joined(separator: "")
		}
	}

	/// The pin that controls what value the active output should have.
	///
	/// p14 on 74HC595N
	let dataPin: GPIO

	/// When this pin is rising, the actual output is updated to match the configured output.
	///
	/// p12 on 74HC595N
	let updatePin: GPIO

	/// The pin that cycles the output to change.
	///
	/// p11 on 74HC595N
	let shiftPin: GPIO

	/// The value to send for enabled outputs. This defaults to `.on`.
	public var enabledValue: GPIO.Value {
		didSet { updateOutput() }
	}
	var disabledValue: GPIO.Value {
		switch enabledValue {
		case .on: return .off
		case .off: return .on
		}
	}

	/// The currently enabled output. This can by any combination of the available outputs.
	public var enabledOutput: Output {
		didSet { updateOutput() }
	}

	/// Creates a new controller for the 74HC595N chip.
	///
	/// - parameter controller: The GPIO controller that handles the pins.
	/// - parameter dataPin: The GPIO pin that is wired to the data pin of the chip. The chip is number 14.
	/// - parameter updatePin: The GPIO pin that is wired to the update pin of the chip. The chip is number 12.
	/// - parameter shiftPin: The GPIO pin that is wired to the serial-shift pin of the chip. The chip is number 11.
	/// - parameter enabledOutput: The initial output value. This defaults to all-disabled.
	/// - parameter enabledValue: The value to send for enabled outputs. This defaults to `.on`.
	public init(
		gpioController: GPIOs,
		dataPin: GPIO.Pin,
		updatePin: GPIO.Pin,
		shiftPin: GPIO.Pin,
		enabledOutput: Output = [],
		enabledValue: GPIO.Value = .on
	) throws {
		self.dataPin = try gpioController.gpio(pin: dataPin, direction: .out)
		self.updatePin = try gpioController.gpio(pin: updatePin, direction: .out)
		self.shiftPin = try gpioController.gpio(pin: shiftPin, direction: .out)
		self.enabledOutput = enabledOutput
		self.enabledValue = enabledValue

		updateOutput()
	}

	func updateOutput() {
		updatePin.value = .off
		for output in Output.allOutputs {
			let isEnabled = enabledOutput.contains(output)
			dataPin.value = isEnabled ? enabledValue : disabledValue

			// Moves the pin-to-change one forward by switching clock-pin off and on again
			shiftPin.value = .off
			sleep(µs: 10)
			shiftPin.value = .on
			sleep(µs: 10)
		}
		updatePin.value = .on
		sleep(µs: 10)
	}
}
