import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class SetupCommandActionTest: XCTestCase {
    
    func test__givenConfigAndPath__shouldCreateTemplateAndConfig() {
        let configPath = Path("/tmp/RedminBot-testing-config")
        let templatePath = Path("/tmp/RedminBot-testing-template")
        let config = Config(redmineUrl: "www.redmine.com", apiAccessKey: "FakeAccessKey")
        let mockSystem = MockSystem()
        
        XCTAssertFalse(configPath.exists)
        XCTAssertFalse(templatePath.exists)

        let sut = SetupCommandAction(config,
                                     configPath: configPath,
                                     defaultTemplatePath: templatePath)
        sut.system = mockSystem
        sut.doAction()
        
        XCTAssertTrue(mockSystem.printSuccessBeInvoke)
        XCTAssertTrue(configPath.exists)
        XCTAssertTrue(templatePath.exists)
        
        try? configPath.delete()
        try? templatePath.delete()
    }
    
}
