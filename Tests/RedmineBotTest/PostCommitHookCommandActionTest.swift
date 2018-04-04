import XCTest
import Foundation
@testable import RedmineBotCore

class PostCommitHookCommandActionTest: XCTestCase {
    
    let config = Config(redmineUrl: "www.redmine.com", apiAccessKey: "FakeAccessKey")
    let context = CommentContext(content: "Unit test content",
                                 authorName: "Test user")
    var sut: PostCommitHookCommandAction?
    var mockRequest: MockCommentRequest?
    
    func test__givenRequestinformation__shouldSendRequest() {
        mockRequest = MockCommentRequest(config)

        sut = PostCommitHookCommandAction()
        sut?.request = mockRequest!
        sut?.git = MockGit.self
        sut?.doAction()
        
        XCTAssertTrue(mockRequest?.issueNumber == 13579)
        XCTAssertTrue(mockRequest?.context?.authorName == String.fakeAuthorName())
        XCTAssertTrue(mockRequest?.context?.content == String.fakecommitMessage())
    }
    
}
