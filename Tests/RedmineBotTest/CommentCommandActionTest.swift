import XCTest
import Foundation
@testable import RedmineBotCore

class CommentCommandActionTest: XCTestCase {
    
    let config = Config(redmineUrl: "www.redmine.com", apiAccessKey: "FakeAccessKey")
    let context = CommentContext(content: "Unit test content",
                                 authorName: "Test user")
    var sut: CommentCommandAction?
    var mockRequest: MockCommentRequest?
    
    func test__givenRequestinformation__shouldSendRequest() {
        mockRequest = MockCommentRequest(config)
        
        sut = CommentCommandAction(12345,
                                   context: context,
                                   request: mockRequest!)
        
        sut?.doAction()
        
        XCTAssertTrue(mockRequest?.context?.authorName == context.authorName)
        XCTAssertTrue(mockRequest?.context?.content == context.content)
    }
    
}