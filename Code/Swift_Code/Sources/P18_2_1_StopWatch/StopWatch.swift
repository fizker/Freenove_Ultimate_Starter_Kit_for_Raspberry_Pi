import ArgumentParser
import Foundation
import SwiftyGPIO
import Shared

let LSBFIRST = 1
let MSBFIRST = 2

let offset_ms: Float = 0.5
let servo_min = offset_ms + 2.5
let servo_max = offset_ms + 12.5

struct SevenSegmentDisplay {
	let latchPin: GPIO
	let dataPin: GPIO
	let clockPin: GPIO
	let d1Pin: GPIO
	let d2Pin: GPIO
	let d3Pin: GPIO
	let d4Pin: GPIO

	init(latchPin: GPIO, dataPin: GPIO, clockPin: GPIO, d1Pin: GPIO, d2Pin: GPIO, d3Pin: GPIO, d4Pin: GPIO) {
		self.latchPin = latchPin
		self.dataPin = dataPin
		self.clockPin = clockPin
		self.d1Pin = d1Pin
		self.d2Pin = d2Pin
		self.d3Pin = d3Pin
		self.d4Pin = d4Pin

		self.latchPin.direction = .OUT
		self.dataPin.direction = .OUT
		self.clockPin.direction = .OUT
		self.d1Pin.direction = .OUT
		self.d2Pin.direction = .OUT
		self.d3Pin.direction = .OUT
		self.d4Pin.direction = .OUT
	}

	private let num = [ 0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90 ]

	func write(number: Int) {
		for digit in Digit.allCases {
			clear()
			selectDigit(digit)

			switch digit {
			case .d4: setDisplay(num[number % 10])
			case .d3: setDisplay(num[number % 100 / 10])
			case .d2: setDisplay(num[number % 1_000 / 100])
			case .d1: setDisplay(num[number % 10_000 / 1_000])
			}

			sleep(ms: 3)
		}
	}

	func clear() {
		setDisplay(0xff)
	}

	private func write(value: Int, to digit: Digit) {
		let pin: GPIO
		switch digit {
		case .d1: pin = d1Pin
		case .d2: pin = d2Pin
		case .d3: pin = d3Pin
		case .d4: pin = d4Pin
		}

		pin.value = value
	}

	private func selectDigit(_ digit: Digit) {
		for digit in Digit.allCases {
			write(value: LOW, to: digit)
		}
		write(value: HIGH, to: digit)
	}

	private func setDisplay(_ value: Int) {
		latchPin.value = LOW
		defer { latchPin.value = HIGH }

		for i in 0..<8 {
			clockPin.value = LOW
			defer { clockPin.value = HIGH }

			let order = MSBFIRST
			switch order {
			case LSBFIRST:
				dataPin.value = 0x01 & (value >> i) == 0x01 ? HIGH : LOW
			case MSBFIRST:
				dataPin.value = 0x80 & (value << i) == 0x80 ? HIGH : LOW
			default: continue
			}
		}
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
		let display = SevenSegmentDisplay(
			latchPin: try gpio.named(.P16),
			dataPin: try gpio.named(.P18),
			clockPin: try gpio.named(.P12),
			d1Pin: <#GPIO#>,
			d2Pin: <#GPIO#>,
			d3Pin: <#GPIO#>,
			d4Pin: <#GPIO#>
		)
	}
}
