import XCTest
import Foundation
@testable import RedmineBotCore

struct FakeVersion: VersionProtocol {
    var major = 1
    var minor = 1
    var patch = 1
}

class VersionCommandActionTest: XCTestCase {
    
    func test__givenVersion__shouldPrintCorrectVersionNumberOnConsoleNormally() {
        let fakeVersion = FakeVersion()
        let mockSystem = MockSystem()
        
        let sut = VersionCommandAction()
        sut.version = fakeVersion
        sut.system = mockSystem
        
        sut.doAction()
        
        XCTAssertTrue(mockSystem.printNormalBeInvoke)
        XCTAssertTrue(mockSystem.printNormalValue == "1.1.1")
    }
    
}
