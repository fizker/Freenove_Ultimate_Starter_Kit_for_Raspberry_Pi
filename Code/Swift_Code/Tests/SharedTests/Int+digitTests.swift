import XCTest
import Shared

final class IntDigitTests: XCTestCase {
	func test__digit__existingDigits__returnsTheDigit() throws {
		let value = 12345
		XCTAssertEqual(value.digit(atPosition: 0), 5)
		XCTAssertEqual(value.digit(atPosition: 1), 4)
		XCTAssertEqual(value.digit(atPosition: 2), 3)
		XCTAssertEqual(value.digit(atPosition: 3), 2)
		XCTAssertEqual(value.digit(atPosition: 4), 1)
	}

	func test__digit__positionIsBeyondBounds__returnsNil() throws {
		let value = 123
		XCTAssertNil(value.digit(atPosition: 4))
	}
}
