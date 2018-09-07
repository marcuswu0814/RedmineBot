//
//  UnInstallHookCommandAction.swift
//  CircuitBreaker
//
//  Created by Tony Yang on 2018/7/7.
//

import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class UnInstallHookCommandActionTest: XCTestCase {
    
    override class func setUp() {
        TempGitRepo.setUP()
    }
    
    func test__uninstallHookWhenHookIsEmpty__shouldShowWarning() {
        let mockSystem = MockSystem()
        let unInstallAction = UnInstallHookCommandAction()
        unInstallAction.system = mockSystem
        
        XCTAssertFalse(unInstallAction.postCommitHookJob.hookPath.exists)
        XCTAssertFalse(unInstallAction.postRewriteHookJob.hookPath.exists)
        
        unInstallAction.doAction()
        
        XCTAssertFalse(unInstallAction.postCommitHookJob.hookPath.exists)
        XCTAssertFalse(unInstallAction.postRewriteHookJob.hookPath.exists)
        XCTAssertTrue(mockSystem.printWarningBeInvoke)
    }
    
    func test__uninstallHookWhenHookAlreadyExist__shouldDeleteHook() {
        let mockSystem = MockSystem()
        let installAction = InstallHookCommandAction()
        installAction.system = mockSystem
        
        XCTAssertFalse(installAction.postCommitHookJob.hookPath.exists)
        XCTAssertFalse(installAction.postRewriteHookJob.hookPath.exists)
        
        installAction.doAction()
        
        XCTAssertTrue(installAction.postCommitHookJob.hookPath.exists)
        XCTAssertTrue(installAction.postRewriteHookJob.hookPath.exists)
        
        let unInstallAction = UnInstallHookCommandAction()
        unInstallAction.system = mockSystem
        
        unInstallAction.doAction()
        
        XCTAssertFalse(installAction.postCommitHookJob.hookPath.exists)
        XCTAssertFalse(installAction.postRewriteHookJob.hookPath.exists)
    }
    
    override class func tearDown() {
        TempGitRepo.tearDown()
        
        super.tearDown()
    }
    
}
