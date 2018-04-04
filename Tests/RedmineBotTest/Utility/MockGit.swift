@testable import RedmineBotCore

class MockGit: GitProtocol {
    
    static func authorName(_ sha: String) -> String? {
        return String.fakeAuthorName()
    }
    
    static func commitTitle(_ sha: String) -> String? {
        return String.fakeCommitTitle()
    }
    
    static func commitMessage(_ sha: String) -> String? {
        return String.fakecommitMessage()
    }
    
}
