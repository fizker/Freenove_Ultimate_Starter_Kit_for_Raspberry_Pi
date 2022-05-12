import ArgumentParser
import SwiftGPIO
import Shared
import Foundation

enum Digit {
	case first, second, third, fourth
}

extension GPIO.Value {
	init(_ bool: Bool) {
		self = bool ? .on : .off
	}

	var flipped: Self {
		switch self {
		case .on: return .off
		case .off: return .on
		}
	}
}

public struct P18_2_1_StopWatch: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "18.2.1_StopWatch")

	public mutating func run() throws {
		let gpioController = GPIOController()

		let digitPins: [GPIO.Pin] = [
			.p17,
			.p27,
			.p22,
			.p5,
		]
		let digits = try digitPins.map { try gpioController.gpio(pin: $0, direction: .out, value: .on) }

		let chip = try SN74HC595N(
			gpioController: gpioController,
			dataPin: .p24,
			updatePin: .p23,
			shiftPin: .p18,
			// We change the enabled-value to off because of how the board is wired
			enabledValue: .off,
			outputUpdateOrder: .highToLow
		)
		let display = SevenSegmentDisplay(chip: chip)

		func selectDigit(_ digit: Digit) {
			digits[0].value = .init(digit == .fourth).flipped
			digits[1].value = .init(digit == .third).flipped
			digits[2].value = .init(digit == .second).flipped
			digits[3].value = .init(digit == .first).flipped
		}

		func display_(_ value: String?, digit: Digit) {
			display.enabledSegments = []
			selectDigit(digit)
			if let value = value {
				display.renderCharacter(.init(rawValue: value) ?? .e)
			} else {
				display.enabledSegments = []
			}
			sleep(ms: 1)
		}

		func display_(_ number: Int) {
			var str = "\(number)"
			display_(str.popLast()?.description, digit: .first)
			display_(str.popLast()?.description, digit: .second)
			display_(str.popLast()?.description, digit: .third)
			display_(str.popLast()?.description, digit: .fourth)
		}

		var secondsPassed = 0
		let start = Date()

		while true {
			let seconds = abs(Int(start.timeIntervalSinceNow))
			if seconds > secondsPassed {
				secondsPassed = seconds
				print("\(secondsPassed) seconds passed")
			}
			display_(secondsPassed)
		}
	}
}
