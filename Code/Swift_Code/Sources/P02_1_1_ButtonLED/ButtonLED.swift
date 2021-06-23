import ArgumentParser
import SwiftyGPIO
import Shared

enum ButtonStatus: Int {
	case pressed = 0
	case released = 1
}
enum LEDStatus: Int {
	case off = 0
	case on = 1
}

public struct P02_1_1_ButtonLED: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "02.1.1_ButtonLED")

	public mutating func run() throws {
		let gpio = GPIOs()

		var board = Board(led: try gpio.named(.P17), button: try gpio.named(.P18))

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
	var ledStatus: LEDStatus = .off {
		didSet {
			led.value = ledStatus.rawValue
		}
	}

	var led: GPIO
	var button: GPIO

	init(led: GPIO, button: GPIO) {
		self.led = led
		self.led.direction = .OUT

		self.button = button
		self.button.direction = .IN
		self.button.pull = .up
	}
}
