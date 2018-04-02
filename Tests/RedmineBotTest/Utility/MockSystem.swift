@testable import RedmineBotCore

class MockSystem: SystemProtocol {
    
    var printSuccessBeInvoke = false
    var printWarningBeInvoke = false
    var printFatalErrorBeInvoke = false

    func printSuccess(_ string: String) {
        printSuccessBeInvoke = true
    }
    
    func printWarning(_ string: String) {
        printWarningBeInvoke = true
    }
    
    func printFatalError(_ string: String) -> Never {
        printFatalErrorBeInvoke = true
        fatalError()
    }
    
}
