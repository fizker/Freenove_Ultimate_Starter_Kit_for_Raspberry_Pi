import ArgumentParser
import P00_0_0_Hello

struct Root: ParsableCommand {
	static var configuration = CommandConfiguration(
		subcommands: [
			P00_0_0_Hello.self,
		]
	)
}

Root.main()
