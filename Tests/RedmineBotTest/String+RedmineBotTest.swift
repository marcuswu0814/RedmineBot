import XCTest
import Foundation
@testable import RedmineBotCore

class StringRedmineBotTest: XCTestCase {
    
    func test__givenString__shuldFindFormatLikeIssueNumber() {
        let string = "[#33456, #12345, #67890] This is a test, and #13579, #24680, ##99999"
        
        let matches = string.findIssuesNumber()
        
        XCTAssertNotNil(matches)
        XCTAssertTrue(matches!.count == 6)

        XCTAssertTrue(matches!.contains("#33456"))
        XCTAssertTrue(matches!.contains("#12345"))
        XCTAssertTrue(matches!.contains("#67890"))
        XCTAssertTrue(matches!.contains("#13579"))
        XCTAssertTrue(matches!.contains("#24680"))
        XCTAssertTrue(matches!.contains("#99999"))
    }
    
    func test__givenStringHadMultiSameIssueNumbers__shouldOnlyFindOne() {
        let string = "[#12345] This is a tes for #12345, #12345"
        
        let matches = string.findIssuesNumber()
        
        XCTAssertNotNil(matches)
        
        XCTAssertTrue(matches!.count == 1)
        XCTAssertTrue(matches!.contains("#12345"))
    }
    
}
