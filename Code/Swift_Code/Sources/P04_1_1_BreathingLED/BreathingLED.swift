import Foundation
import ArgumentParser
import SwiftGPIO
import Shared

public struct P04_1_1_BreathingLED: ParsableCommand {
	public static var configuration = CommandConfiguration(
		commandName: "04.1.1",
		abstract: "BreathingLED"
	)

	public init() {
	}

	public func run() throws {
		print("Starting")
		let gpio = GPIOController()
		var pwm = try gpio.pwm.pwm(named: .p18)

		while(true) {
			for i in 0..<100 {
				pwm.duty = Float(i)
				sleep(ms: 30)
			}

			sleep(ms: 300)

			for i in (0..<100).reversed() {
				pwm.duty = Float(i)
				sleep(ms: 30)
			}

			sleep(ms: 300)
		}
	}
}
