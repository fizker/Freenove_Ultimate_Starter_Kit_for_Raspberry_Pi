import ArgumentParser
import SwiftGPIO
import Shared

enum ButtonStatus: RawRepresentable {
	case pressed
	case released

	init?(rawValue: GPIO.Value) {
		switch rawValue {
		case .on: self = .released
		case .off: self = .pressed
		}
	}

	var rawValue: GPIO.Value {
		switch self {
		case .pressed: return .off
		case .released: return .on
		}
	}
}

public struct P02_1_1_ButtonLED: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "02.1.1_ButtonLED")

	public mutating func run() throws {
		let gpios = GPIOs()

		var board = Board(led: try gpios.gpio(pin: .p17, direction: .out), button: try gpios.gpio(pin: .p18, direction: .in))

		while(true) {
			guard let buttonStatus = ButtonStatus(rawValue: board.button.value)
			else {
				print("unknown value: \(board.button.value)")
				continue
			}

			board.buttonStatus = buttonStatus
		}
	}
}

struct Board {
	var buttonStatus: ButtonStatus = .released {
		didSet {
			guard buttonStatus != oldValue
			else { return }

			switch buttonStatus {
			case .pressed:
				ledStatus = .on
				print("Button was pressed, turning on LED")
			case .released:
				ledStatus = .off
				print("Button was released, turning off LED")
			}
		}
	}
	var ledStatus: GPIO.Value = .off {
		didSet {
			led.value = ledStatus
		}
	}

	var led: GPIO
	var button: GPIO

	init(led: GPIO, button: GPIO) {
		self.led = led

		self.button = button
		self.button.pull = .up
	}
}
