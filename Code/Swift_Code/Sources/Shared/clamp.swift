public func clamp<T: Comparable>(_ n: T, between a: T, and b: T) -> T {
	let lower = min(a, b)
	let upper = max(a, b)
	return max(min(upper, n), lower)
}

public extension Comparable {
	func clamped(between a: Self, and b: Self) -> Self {
		return clamp(self, between: a, and: b)
	}
}
