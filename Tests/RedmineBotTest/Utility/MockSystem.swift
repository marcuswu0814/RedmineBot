@testable import RedmineBotCore

class MockSystem: SystemProtocol {
    
    var printNormalBeInvoke = false
    var printNormalValue = ""
    var printSuccessBeInvoke = false
    var printSuccessValue = ""
    var printWarningBeInvoke = false
    var printWarningValue = ""
    var printFatalErrorBeInvoke = false
    var printFatalErrorValue = ""

    func printNormal(_ string: String) {
        printNormalBeInvoke = true
        printNormalValue = string
    }
    
    func printSuccess(_ string: String) {
        printSuccessBeInvoke = true
        printSuccessValue = string
    }
    
    func printWarning(_ string: String) {
        printWarningBeInvoke = true
        printWarningValue = string
    }
    
    func printFatalError(_ string: String) -> Never {
        printFatalErrorBeInvoke = true
        printFatalErrorValue = string
        fatalError()
    }
    
}
