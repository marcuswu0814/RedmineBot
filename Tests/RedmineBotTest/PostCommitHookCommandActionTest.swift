import XCTest
import Foundation
@testable import RedmineBotCore

class PostCommitHookCommandActionTest: XCTestCase {
    
    let config = Config(redmineUrl: "www.redmine.com", apiAccessKey: "FakeAccessKey")
    var sut: PostCommitHookCommandAction?
    var mockRequest: MockCommentRequest?
    
    func test__givenRequestInformation__shouldSendRequest() {
        mockRequest = MockCommentRequest(config)

        sut = PostCommitHookCommandAction()
        sut?.request = mockRequest!
        sut?.git = MockGit.self
        sut?.doAction()
        
        XCTAssertTrue(mockRequest?.issueNumber == 13579)
        XCTAssertTrue(mockRequest?.context?.authorName == String.fakeAuthorName())
        XCTAssertTrue(mockRequest?.context?.content == String.fakeCommitMessage())
    }
    
}
