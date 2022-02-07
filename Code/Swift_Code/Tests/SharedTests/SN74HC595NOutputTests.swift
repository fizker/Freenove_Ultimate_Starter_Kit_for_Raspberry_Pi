import XCTest
@testable import Shared

final class SN74HC595NOutputTests: XCTestCase {
	typealias Output = SN74HC595N.Output

	func test__bits__baseValues__returnsExpectedValue() throws {
		let tests: [(output: Output, bits: String, value: Int)] = [
			( .output1, "00000001", 1),
			( .output2, "00000010", 2),
			( .output3, "00000100", 4),
			( .output4, "00001000", 8),
			( .output5, "00010000", 16),
			( .output6, "00100000", 32),
			( .output7, "01000000", 64),
			( .output8, "10000000", 128),
		]
		for test in tests {
			XCTAssertEqual("\(test.output.rawValue) -> \(test.output.bits)", "\(test.value) -> \(test.bits)")
		}
	}

	func test__initFromBits__baseInputs__initsToExpectedValue() throws {
		let tests: [(input: String, value: Int)] = [
			("00000001", 1),
			("00000010", 2),
			("00000100", 4),
			("00001000", 8),
			("00010000", 16),
			("00100000", 32),
			("01000000", 64),
			("10000000", 128),
		]

		for test in tests {
			let actual = try Output(bits: test.input)
			XCTAssertEqual("\(actual.bits) -> \(actual.rawValue)", "\(test.input) -> \(test.value)")
		}
	}

	func test__initFromBits__complexInputs__initsToExpectedValue() throws {
		let tests: [(input: String, value: Int)] = [
			("01010101", 85),
			("10101010", 170),
			("01100110", 102),
		]

		for test in tests {
			let actual = try Output(bits: test.input)
			XCTAssertEqual("\(actual.bits) -> \(actual.rawValue)", "\(test.input) -> \(test.value)")
		}
	}
}
