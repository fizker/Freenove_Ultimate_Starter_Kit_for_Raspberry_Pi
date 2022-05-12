import ArgumentParser
import SwiftGPIO
import Shared

public struct P07_1_1_ADC: ParsableCommand {
	public init() {

	}

	public static var configuration = CommandConfiguration(commandName: "07.1.1_ADC")

	public func run() throws {
		let maxVoltage = 3.3
		let maxValue = 255.0

		let gpio = GPIOController()
		let adc = try gpio.hardwareI2C(device: .new)

		while true {
			let adcValue = adc.read(.a0)
			let voltage = Double(adcValue) / maxValue * maxVoltage
			print("ADC value : \(adcValue) ,\tVoltage : \(String(format: "%.2f", voltage))V")

			sleep(Hz: 5)
		}
	}
}
