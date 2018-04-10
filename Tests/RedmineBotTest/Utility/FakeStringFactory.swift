extension String {
    
    static func fakeRepoName() -> String {
        return "FakeRepo"
    }
    
    static func fakeBranchName() -> String {
        return "FakeBranch"
    }
    
    static func fakeAuthorName() -> String {
        return "Test author name"
    }
    
    static func fakeCommitTitle() -> String {
        return "[#13579] This is test commit title"
    }
    
    static func fakeCommitMessage() -> String {
        let fakecommitMessage =
        """
        commit newHash
        Author: Test author name <testUserName@test.com>

            [#13579] This is test commit title

            This is commit message body.
        """
        
        return fakecommitMessage
    }
    
}
