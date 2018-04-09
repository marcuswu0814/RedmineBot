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
        
        XCTAssertFalse(sut.postCommitHookJob.hookPath.exists)
        XCTAssertFalse(sut.postRewriteHookJob.hookPath.exists)
        
        sut.doAction()
        
        XCTAssertTrue(sut.postCommitHookJob.hookPath.exists)
        XCTAssertTrue(sut.postRewriteHookJob.hookPath.exists)
        
        let postRewriteInstallSuccess = try? sut.postCommitHookJob.hookPath.read().contains(sut.postCommitHookJob.hookContent)
        let postCommitHookInstallSuccess = try? sut.postRewriteHookJob.hookPath.read().contains(sut.postRewriteHookJob.hookContent)
        
        XCTAssertTrue(postRewriteInstallSuccess!)
        XCTAssertTrue(postCommitHookInstallSuccess!)
        
        addTeardownBlock {
            try? sut.postCommitHookJob.hookPath.delete()
            try? sut.postRewriteHookJob.hookPath.delete()
        }
    }
    
    func test__installHookWhenHookAlreadyInstall__shouldShowWarning() {
        let mockSystem = MockSystem()
        let sut = InstallHookCommandAction()
        sut.system = mockSystem
        
        sut.doAction()
        sut.doAction()
        
        let postRewriteAlreadyInstallSuccess = try? sut.postRewriteHookJob.hookPath.read().contains(sut.postRewriteHookJob.hookContent)
        let postCommitHookAlreadyInstallSuccess = try? sut.postCommitHookJob.hookPath.read().contains(sut.postCommitHookJob.hookContent)
        
        XCTAssertTrue(postRewriteAlreadyInstallSuccess!)
        XCTAssertTrue(postCommitHookAlreadyInstallSuccess!)
        
        XCTAssertTrue(mockSystem.printWarningBeInvoke)

        addTeardownBlock {
            try? sut.postRewriteHookJob.hookPath.delete()
            try? sut.postCommitHookJob.hookPath.delete()
        }
    }
    
    func test__installHookWhenHookAlreadyExist__shouldAppendToHook() {
        let mockSystem = MockSystem()
        let sut = InstallHookCommandAction()
        sut.system = mockSystem
        sut.doAction()
        
        try? sut.postRewriteHookJob.hookPath.write("Replace already exist hook")
        try? sut.postCommitHookJob.hookPath.write("Replace already exist hook")
        
        let postRewriteHookReplaceSuccess = try? sut.postRewriteHookJob.hookPath.read().contains("Replace already exist hook")
        let postCommitHookReplaceSuccess = try? sut.postCommitHookJob.hookPath.read().contains("Replace already exist hook")
        
        XCTAssertTrue(postRewriteHookReplaceSuccess!)
        XCTAssertTrue(postCommitHookReplaceSuccess!)
        
        sut.doAction()

        let postRewriteAppendedSuccess = try? sut.postRewriteHookJob.hookPath.read().contains(sut.postRewriteHookJob.hookContent)
        let postCommitHookAppendedSuccess = try? sut.postCommitHookJob.hookPath.read().contains(sut.postCommitHookJob.hookContent)
        
        XCTAssertTrue(postRewriteAppendedSuccess!)
        XCTAssertTrue(postCommitHookAppendedSuccess!)
        
        addTeardownBlock {
            try? sut.postCommitHookJob.hookPath.delete()
            try? sut.postRewriteHookJob.hookPath.delete()
        }
    }
    
    override class func tearDown() {
        TempGitRepo.tearDown()
        
        super.tearDown()
    }
}
