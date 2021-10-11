import Foundation
import ArgumentParser
import SwiftGPIO
import Shared

public struct P01_1_1_Blink: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(commandName: "01.1.1_Blink")

	public func run() throws {
		let gpio = GPIOs()

		let led = try gpio.gpio(pin: .p17, direction: .out)

		while(true) {
			print("Turning on")
			led.value = .on
			sleep(s: 1)
			print("Turning off")
			led.value = .off
			sleep(s: 1)
		}
	}
}
