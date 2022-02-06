import ArgumentParser
import SwiftGPIO
import Shared

typealias Output = SN74HC595N.Output

public struct P17_1_1_LightWater02: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "17.1.1_LightWater02")

	public mutating func run() throws {
		let chip = try SN74HC595N(
			gpioController: GPIOs(),
			dataPin: .p17,
			updatePin: .p27,
			shiftPin: .p22,
			// We change the enabled-value to off because of how the board is wired
			enabledValue: .off
		)

		func update(_ pins: [Output]) {
			for x in pins {
				chip.enabledOutput = x
				sleep(ms: 100)
			}
		}

		while true {
			update(Output.allOutputs)
			update(Output.allOutputs.reversed())
		}
	}
}
