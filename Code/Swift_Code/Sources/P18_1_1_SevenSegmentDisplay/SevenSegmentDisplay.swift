import ArgumentParser
import SwiftGPIO
import Shared

public struct P18_1_1_SevenSegmentDisplay: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "18.1.1_SevenSegmentDisplay")

	public mutating func run() throws {
		let chip = try SN74HC595N(
			gpioController: GPIOs(),
			dataPin: .p17,
			updatePin: .p27,
			shiftPin: .p22,
			// We change the enabled-value to off because of how the board is wired
			enabledValue: .off,
			// The pin direction needs to be highest digit first
			outputUpdateOrder: .highToLow
		)
		let display = SevenSegmentDisplay(chip: chip)
		let outputs = SevenSegmentDisplay.Character.allCases
			.map(\.segments)

		while true {
			for output in outputs {
				display.enabledSegments = output
				sleep(ms: 500)
			}
			for output in outputs {
				display.enabledSegments = output + [.dot]
				sleep(ms: 500)
			}
		}
	}
}
