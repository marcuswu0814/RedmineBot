import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class InstallHookCommandActionTest: XCTestCase {
    
    override class func setUp() {
        TempGitRepo.setUP()
    }
    
    func test__installHookInNewRepo__shouldInstallPostCommitAndPostRewriteHook() {
        let mockSystem = MockSystem()
        let sut = InstallHookCommandAction()
        sut.system = mockSystem
        
        XCTAssertFalse(sut.postCommitHookPath.exists)
        XCTAssertFalse(sut.postRewriteHookPath.exists)
        
        sut.doAction()
        
        XCTAssertTrue(sut.postCommitHookPath.exists)
        XCTAssertTrue(sut.postRewriteHookPath.exists)
    }
    
    override class func tearDown() {
        TempGitRepo.tearDown()
        
        super.tearDown()
    }
}
