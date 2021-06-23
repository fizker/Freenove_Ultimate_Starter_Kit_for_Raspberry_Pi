import ArgumentParser

public struct P00_0_0_Hello: ParsableCommand {
	public init() {}

	public static var configuration = CommandConfiguration(commandName: "00.0.0_Hello")

	public func run() {
		print("hello world")
	}
}
