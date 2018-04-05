import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class GitTest: XCTestCase {
    
    static let tempDir = Path("/tmp/RedminBot-gitTest")
    static let userName = "Test User"
    static let commitMessage = "Test Commit message"
    
    override class func setUp() {
        super.setUp()
        
        try? tempDir.mkdir()
        
        Path.current = tempDir
        
        _ = Bash.run("git", arguments: ["init"])
        _ = Bash.run("git", arguments: ["config", "--local", "user.name", userName])
        _ = Bash.run("touch", arguments: ["testFile"])
        _ = Bash.run("git", arguments: ["add", "--all"])
        _ = Bash.run("git", arguments: ["commit", "--m", commitMessage])
    }
    
    func test__shuoldGetCurrentAuthorName() {
        let authorName = Git.authorName("")
        
        XCTAssertTrue(authorName == GitTest.userName)
    }
    
    func test__shuoldGetCurrentCommitMessage() {
        let commitMessage = Git.commitMessage("")
        
        let containsCommitMessage = commitMessage?.contains(GitTest.commitMessage)
        let containsAuthorName = commitMessage?.contains(GitTest.userName)

        XCTAssertTrue(containsCommitMessage!)
        XCTAssertTrue(containsAuthorName!)
    }
    
    func test__sholdGetCurrentCommitTitle() {
        let commitTitle = Git.commitTitle("")

        let containsCommitTitle = commitTitle?.contains(GitTest.commitMessage)
        
        XCTAssertTrue(containsCommitTitle!)
    }
 
    override class func tearDown() {
        let tempDir = Path("/tmp/RedminBot-gitTest")
        try? tempDir.delete()
        
        super.tearDown()
    }
}
