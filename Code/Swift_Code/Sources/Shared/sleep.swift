import Foundation

@discardableResult
public func sleep(ms: UInt32) -> Int32 {
	sleep(µs: ms * 1_000)
}

@discardableResult
public func sleep(µs: UInt32) -> Int32 {
	usleep(µs)
}
