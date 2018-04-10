import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class SetupCommandActionTest: XCTestCase {
    
    func test__givenConfigAndPath__shouldCreateTemplateAndConfig() {
        let configPath = Path("/tmp/RedminBot-testing-config")
        let config = Config(redmineUrl: "www.redmine.com", apiAccessKey: "FakeAccessKey")
        let mockSystem = MockSystem()
        
        XCTAssertFalse(configPath.exists)

        let sut = SetupCommandAction(config,
                                     configPath: configPath)
        sut.system = mockSystem
        sut.doAction()
        
        XCTAssertTrue(mockSystem.printSuccessBeInvoke)
        XCTAssertTrue(configPath.exists)
        
        try? configPath.delete()
    }
    
}
