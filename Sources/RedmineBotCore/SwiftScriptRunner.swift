// https://github.com/mgrebenets/SwiftScriptRunner

import Foundation

open class SwiftScriptRunner {

    private var count = 0

    private let runLoop = RunLoop.current

    public init() {}

    open func lock() {
        count += 1
    }

    open func unlock() {
        count -= 1
    }

    open func wait() {
        while count > 0 &&
            runLoop.run(mode: .defaultRunLoopMode,
                        before: Date(timeIntervalSinceNow: 0.1)) {
        }
    }
}

