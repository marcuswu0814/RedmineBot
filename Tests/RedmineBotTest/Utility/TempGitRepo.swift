import Foundation
import PathKit
@testable import RedmineBotCore

struct TempGitRepo {
    
    static let tempDir = Path("/tmp/RedminBot-gitTest")
    static let userName = "Test User"
    static let commitMessage = "Test Commit message"
    
    static func setUP() {
        try? tempDir.mkdir()
        
        Path.current = tempDir
        
        _ = Bash.run("git", arguments: ["init"])
        _ = Bash.run("git", arguments: ["config", "--local", "user.name", userName])
        _ = Bash.run("touch", arguments: ["testFile"])
        _ = Bash.run("git", arguments: ["add", "--all"])
        _ = Bash.run("git", arguments: ["commit", "--m", commitMessage])
    }
    
    static func tearDown() {
        let tempDir = Path("/tmp/RedminBot-gitTest")
        try? tempDir.delete()
    }
    
}
