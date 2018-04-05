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
        
        let postRewriteInstallSuccess = try? sut.postRewriteHookPath.read().contains(sut.postRewriteHook)
        let postCommitHookInstallSuccess = try? sut.postCommitHookPath.read().contains(sut.postCommitHook)
        
        XCTAssertTrue(postRewriteInstallSuccess!)
        XCTAssertTrue(postCommitHookInstallSuccess!)
        
        addTeardownBlock {
            try? sut.postCommitHookPath.delete()
            try? sut.postRewriteHookPath.delete()
        }
    }
    
    func test__installHookWhenHookAlreadyInstall__shouldShowWarning() {
        let mockSystem = MockSystem()
        let sut = InstallHookCommandAction()
        sut.system = mockSystem
        
        sut.doAction()
        sut.doAction()
        
        let postRewriteAlreadyInstallSuccess = try? sut.postRewriteHookPath.read().contains(sut.postRewriteHook)
        let postCommitHookAlreadyInstallSuccess = try? sut.postCommitHookPath.read().contains(sut.postCommitHook)
        
        XCTAssertTrue(postRewriteAlreadyInstallSuccess!)
        XCTAssertTrue(postCommitHookAlreadyInstallSuccess!)
        
        XCTAssertTrue(mockSystem.printWarningBeInvoke)

        addTeardownBlock {
            try? sut.postCommitHookPath.delete()
            try? sut.postRewriteHookPath.delete()
        }
    }
    
    func test__installHookWhenHookAlreadyExist__shouldAppendToHook() {
        let mockSystem = MockSystem()
        let sut = InstallHookCommandAction()
        sut.system = mockSystem
        sut.doAction()
        
        try? sut.postRewriteHookPath.write("Replace already exist hook")
        try? sut.postCommitHookPath.write("Replace already exist hook")
        
        let postRewriteHookReplaceSuccess = try? sut.postRewriteHookPath.read().contains("Replace already exist hook")
        let postCommitHookReplaceSuccess = try? sut.postCommitHookPath.read().contains("Replace already exist hook")
        
        XCTAssertTrue(postRewriteHookReplaceSuccess!)
        XCTAssertTrue(postCommitHookReplaceSuccess!)
        
        sut.doAction()

        let postRewriteAppendedSuccess = try? sut.postRewriteHookPath.read().contains(sut.postRewriteHook)
        let postCommitHookAppendedSuccess = try? sut.postCommitHookPath.read().contains(sut.postCommitHook)
        
        XCTAssertTrue(postRewriteAppendedSuccess!)
        XCTAssertTrue(postCommitHookAppendedSuccess!)
        
        addTeardownBlock {
            try? sut.postCommitHookPath.delete()
            try? sut.postRewriteHookPath.delete()
        }
    }
    
    override class func tearDown() {
        TempGitRepo.tearDown()
        
        super.tearDown()
    }
}
