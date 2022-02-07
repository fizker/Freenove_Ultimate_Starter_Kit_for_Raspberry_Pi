typealias Output = SN74HC595N.Output

public class SevenSegmentDisplay {
	public let chip: SN74HC595N

	public init(chip: SN74HC595N, enabledSegments: [Segment] = []) {
		self.chip = chip
		self.enabledSegments = enabledSegments

		chip.enabledOutput = enabledSegments.map(\.output).combined()
	}

	/// Updates the enabled segments
	public var enabledSegments: [Segment] {
		didSet {
			chip.enabledOutput = enabledSegments.map(\.output).combined()
		}
	}

	/// Renders a predefined character
	public func renderCharacter(_ char: Character) {
		enabledSegments = char.segments
	}

	/// The segments of the display is arranged as following
	/// ```
	///  -- A --
	///  |     |
	///  F     B
	///  |     |
	///  -- G --
	///  |     |
	///  E     C
	///  |     |
	///  -- D -- dot
	///  ```
	public enum Segment: CaseIterable {
		case a
		case b
		case c
		case d
		case e
		case f
		case g
		case dot

		var output: Output {
			switch self {
			case .a: return .output1
			case .b: return .output2
			case .c: return .output3
			case .d: return .output4
			case .e: return .output5
			case .f: return .output6
			case .g: return .output7
			case .dot: return .output8
			}
		}
	}

	public enum Character: String, CaseIterable {
		/// ```
		///  _
		/// | |
		/// |_|
		/// ```
		case zero = "0"
		/// ```
		///
		///   |
		///   |
		/// ```
		case one = "1"
		/// ```
		///  _
		///  _|
		/// |_
		/// ```
		case two = "2"
		/// ```
		///  _
		///  _|
		///  _|
		/// ```
		case three = "3"
		/// ```
		///
		/// |_|
		///   |
		/// ```
		case four = "4"
		/// ```
		///  _
		/// |_
		///  _|
		/// ```
		case five = "5"
		/// ```
		///  _
		/// |_
		/// |_|
		/// ```
		case six = "6"
		/// ```
		///  _
		///   |
		///   |
		/// ```
		case seven = "7"
		/// ```
		///  _
		/// |_|
		/// |_|
		/// ```
		case eight = "8"
		/// ```
		///  _
		/// |_|
		///  _|
		/// ```
		case nine = "9"

		/// ```
		///  _
		/// |_|
		/// | |
		/// ```
		case a
		/// ```
		///
		/// |_
		/// |_|
		/// ```
		case b
		/// ```
		///  _
		/// |
		/// |_
		/// ```
		case c
		/// ```
		///
		///  _|
		/// |_|
		/// ```
		case d
		/// ```
		///  _
		/// |_
		/// |_
		/// ```
		case e
		/// ```
		///  _
		/// |_
		/// |
		/// ```
		case f

		public var segments: [Segment] {
			switch self {
			// 0011_1111
			case .zero:
				return [ .a, .b, .c, .d, .e, .f ]
			// 0000_0110
			case .one:
				return [ .b, .c ]
			// 0101_1011
			case .two:
				return [ .a, .b, .g, .e, .d ]
			// 0100_1111
			case .three:
				return [ .a, .b, .c, .d, .g ]
			// 0110_0110
			case .four:
				return [ .b, .c, .f, .g ]
			// 0110_1101
			case .five:
				return [ .a, .c, .g, .f, .d ]
			// 0111_1101
			case .six:
				return [ .a, .c, .d, .e, .f, .g ]
			// 0000_0111
			case .seven:
				return [ .a, .b, .c ]
			// 0111_1111
			case .eight:
				return [ .a, .b, .c, .d, .e, .f, .g ]
			// 0110_1111
			case .nine:
				return [ .a, .b, .c, .d, .f, .g ]

			// 0111_0111
			case .a:
				return [ .a, .b, .c, .e, .f, .g ]
			// 0111_1100
			case .b:
				return [ .c, .d, .e, .f, .g ]
			// 0011_1001
			case .c:
				return [ .a, .d, .e, .f ]
			// 0101_1110
			case .d:
				return [ .b, .c, .d, .e, .g ]
			// 0111_1001
			case .e:
				return [ .a, .d, .e, .f, .g ]
			// 0111_0001
			case .f:
				return [ .a, .e, .f, .g ]
			}
		}
	}
}
