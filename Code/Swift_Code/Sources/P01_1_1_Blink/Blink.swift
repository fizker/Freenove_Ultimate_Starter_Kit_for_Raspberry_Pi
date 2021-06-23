import Foundation
import ArgumentParser
import Shared

public struct P01_1_1_Blink: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "01.1.1_Blink")

	public func run() throws {
		let gpio = GPIOs()

		let led = try gpio.named(.P17)
		led.direction = .OUT

		while(true) {
			print("Turning on")
			led.value = 1
			sleep(1)
			print("Turning off")
			led.value = 0
			sleep(1)
		}
	}
}
