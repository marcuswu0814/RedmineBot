@testable import RedmineBotCore

class MockCommentRequest: CommentRequest {
    
    var issueNumber: Int?
    var context: CommentContext?
    
    override func send(to issueNumber: Int, wtih context: CommentContext) {
        self.issueNumber = issueNumber
        self.context = context
    }
    
}
