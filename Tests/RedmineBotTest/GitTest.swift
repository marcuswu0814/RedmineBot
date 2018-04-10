import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class GitTest: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        
        TempGitRepo.setUP()
    }
    
    func test__shuoldGetCurrentAuthorName() {
        let authorName = Git.authorName("")
        
        XCTAssertTrue(authorName == TempGitRepo.userName)
    }
    
    func test__shuoldGetCurrentCommitMessage() {
        let commitMessage = Git.commitMessage("")
        
        let containsCommitMessage = commitMessage?.contains(TempGitRepo.commitMessage)
        let containsAuthorName = commitMessage?.contains(TempGitRepo.userName)

        XCTAssertTrue(containsCommitMessage!)
        XCTAssertTrue(containsAuthorName!)
    }
    
    func test__shouldGetCurrentCommitTitle() {
        let commitTitle = Git.commitTitle("")

        let containsCommitTitle = commitTitle?.contains(TempGitRepo.commitMessage)
        
        XCTAssertTrue(containsCommitTitle!)
    }
    
    func test_shouldGetCurrentBranchName() {
        let branchName = Git.branchName()
        
        XCTAssertTrue(branchName == "master")
    }
    
    func test_shouldGetCurrentRepoName() {
        let repoName = Git.repoName()
        
        XCTAssertTrue(repoName == TempGitRepo.tempDir.lastComponent)
    }
 
    override class func tearDown() {
        TempGitRepo.tearDown()
        
        super.tearDown()
    }
}
