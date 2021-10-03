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

		func writeAll<T: Sequence>(_ all: T) where T.Element == Float {
			for value in all {
				servo.duty = value
				sleep(ms: 1)
			}
			sleep(ms: 500)
		}

		let angles = (0...180).map { angle -> Float in
			(servo_max - servo_min) * Float(angle) / 180 + servo_min
		}
		while true {
			print("Going to max")
			writeAll(angles)
			print("Going to min")
			writeAll(angles.reversed())
		}
	}
}
