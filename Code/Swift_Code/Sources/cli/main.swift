import ArgumentParser
import P00_0_0_Hello
import P01_1_1_Blink

struct Root: ParsableCommand {
	static var configuration = CommandConfiguration(
		subcommands: [
			P00_0_0_Hello.self,
			P01_1_1_Blink.self,
		]
	)
}

Root.main()
