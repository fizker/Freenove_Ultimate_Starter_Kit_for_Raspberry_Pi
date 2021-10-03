import ArgumentParser
import Foundation
import SwiftyGPIO
import Shared

let offset_ms: Float = 0.5
let servo_min = offset_ms + 2.5
let servo_max = offset_ms + 12.5

struct SevenSegmentDisplay {
	let d1Pin: GPIO
	let d2Pin: GPIO
	let d3Pin: GPIO
	let d4Pin: GPIO

	init(d1Pin: GPIO, d2Pin: GPIO, d3Pin: GPIO, d4Pin: GPIO) {
		self.d1Pin = d1Pin
		self.d2Pin = d2Pin
		self.d3Pin = d3Pin
		self.d4Pin = d4Pin

		d1Pin.direction = .OUT
		d2Pin.direction = .OUT
		d3Pin.direction = .OUT
		d4Pin.direction = .OUT
	}

	func write(_ number: Int) {
		
	}

	enum Digit: CaseIterable {
		case d1, d2, d3, d4
	}
}

public struct P18_2_1_StopWatch: ParsableCommand {
	public init() {

	}

	public static var configuration = CommandConfiguration(commandName: "18.2.1_StopWatch")

	public func run() throws {
		let gpio = GPIOs()
		let dataPin = try gpio.named(.P18)
		dataPin.direction = .OUT
		let latchPin = try gpio.named(.P16)
		latchPin.direction = .OUT
		let clockPin = try gpio.named(.P12)
		clockPin.direction = .OUT
	}

	func write(pin: Int, value: Int) {}

	func selectDigit(_ digit: Digit) {
		for digit in Digit.allCases {
			write(pin: digit.pin, value: LOW)
		}
		write(pin: digit.pin, value: HIGH)
	}
}
