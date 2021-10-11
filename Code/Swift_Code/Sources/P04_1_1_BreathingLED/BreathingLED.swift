import Foundation
import ArgumentParser
import SwiftGPIO
import Shared

public struct P04_1_1_BreathingLED: ParsableCommand {
	public static var configuration = CommandConfiguration(commandName: "04.1.1_BreathingLED")

	public init() {
	}

	public func run() throws {
		print("Starting")
		let gpio = GPIOs()
		let pwm = gpio.pwm()

		guard var pwm = try pwm?.pwm(named: .P18)
		else { throw PulseWidthModulationError.notFound }

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
