import ArgumentParser
import SwiftGPIO
import Shared

public struct P17_1_1_LightWater02: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "17.1.1_LightWater02")

	public mutating func run() throws {
		let controller = GPIOs()
		let dataPin = try controller.gpio(pin: .p17, direction: .out) // p14 on 74HC595
		let latchPin = try controller.gpio(pin: .p27, direction: .out) // p12 on 74HC595
		let clockPin = try controller.gpio(pin: .p22, direction: .out) // p11 on 74HC595

		func shiftOut(activeLED: Int) {
			for i in 0..<8 {
				clockPin.value = .off
				dataPin.value = activeLED == i ? .off : .on
				sleep(ms: 10)
				clockPin.value = .on
				sleep(ms: 10)
			}
		}

		func update(_ pins: [Int]) {
			for x in pins {
				latchPin.value = .off
				shiftOut(activeLED: x)
				latchPin.value = .on
				sleep(ms: 100)
			}
		}

		while true {
			update(Array(0..<8))
			update((0..<8).reversed())
		}
	}
}
