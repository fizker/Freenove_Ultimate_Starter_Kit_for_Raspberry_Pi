import ArgumentParser
import Foundation
import SwiftyGPIO
import Shared

public struct P15_1_1_Sweep: ParsableCommand {
	let offset_ms: Float
	let servo_min: Float
	let servo_max: Float

	public init() {
		offset_ms = 0.5
		servo_min = offset_ms + 2.5
		servo_max = offset_ms + 12.5
	}

	public static let configuration = CommandConfiguration(commandName: "15.1.1_Sweep")

	public mutating func run() throws {
		let gpio = GPIOs()
		var servo = try gpio.softwarePulseWidthModulation(for: .P18, hz: 50)

		func write(_ a: Int) {
			let angle = Float(a).clamped(between: 0, and: 180)
			let val = (servo_max - servo_min) * angle / 180 + servo_min
			servo.duty = val
		}

		while true {
			for value in 0...180 {
				write(value)
				sleep(ms: 1)
			}
			sleep(ms: 500)
			for value in (0...180).reversed() {
				write(value)
				sleep(ms: 1)
			}
			sleep(ms: 500)
		}
	}
}
