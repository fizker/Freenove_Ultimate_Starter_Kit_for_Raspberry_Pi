import ArgumentParser
import P00_0_0_Hello
import P01_1_1_Blink
import P02_1_1_ButtonLED

struct Root: ParsableCommand {
	static var configuration = CommandConfiguration(
		subcommands: [
			P00_0_0_Hello.self,
			P01_1_1_Blink.self,
			P02_1_1_ButtonLED.self,
		]
	)
}

Root.main()
