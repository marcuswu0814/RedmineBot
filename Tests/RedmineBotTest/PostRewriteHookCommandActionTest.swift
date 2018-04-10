import XCTest
import Foundation
@testable import RedmineBotCore

class MockCommitsDiffReader: CommitsDiffReader {
    
    override func commitsDiff() -> [CommitDiff] {
        return [CommitDiff(oldHash: "oldHash", newHash: "newHash")]
    }
    
}

class PostRewriteHookCommandActionTest: XCTestCase {
    
    let config = Config(redmineUrl: "www.redmine.com", apiAccessKey: "FakeAccessKey")
    var sut: PostRewriteHookCommandAction?
    var mockRequest: MockCommentRequest?
    
    func test__givenRequestInformation__shouldSendRequest() {
        mockRequest = MockCommentRequest(config)

        sut = PostRewriteHookCommandAction()
        sut?.provider = MockCommitsDiffReader()
        sut?.request = mockRequest!
        sut?.git = MockGit.self
       
        sut?.doAction()
        
        let requestMessageContainsCommitMessage = mockRequest?.context?.content.contains(String.fakeCommitMessage())

        XCTAssertTrue(mockRequest?.issueNumber == 13579)
        XCTAssertTrue(mockRequest?.context?.authorName == String.fakeAuthorName())
        XCTAssertTrue(requestMessageContainsCommitMessage!)
    }
    
}
