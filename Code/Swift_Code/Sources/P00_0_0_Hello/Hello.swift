import ArgumentParser

public struct P00_0_0_Hello: AsyncParsableCommand {
	public init() {}

	public static var configuration = CommandConfiguration(commandName: "00.0.0_Hello")

	public func run() async throws {
		print("hello world")
		try await Task.sleep(s: 2)
		print("hello after waiting")
	}
}

extension Task where Success == Never, Failure == Never {
	static func sleep(s: UInt64) async throws {
		try await Self.sleep(ms: s * 1_000)
	}

	static func sleep(ms: UInt64) async throws {
		try await Self.sleep(µs: ms * 1_000)
	}

	static func sleep(µs: UInt64) async throws {
		try await Self.sleep(nanoseconds: µs * 1_000)
	}
}
