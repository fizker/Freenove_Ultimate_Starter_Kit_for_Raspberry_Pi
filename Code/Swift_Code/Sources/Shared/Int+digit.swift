import Foundation

public extension Int {
	/// Returns the digit at the given position, or `nil` if the position is out-of-bounds.
	///
	/// The position is 0-indexed counted from least-significant. For example, positions for `5786` would be:
	/// - 0 ->  6
	/// - 1 ->  8
	/// - 2 ->  7
	/// - 3 ->  5
	///
	/// - parameter pos: The 0-indexed position.
	/// - returns: The digit at that position, or `nil` if out-of-bounds.
	func digit(atPosition pos: UInt) -> Int? {
		let ext = Int(pow(10, Double(pos)))
		guard ext - 1 < self
		else { return nil }

		return (self / ext) % 10
	}
}
