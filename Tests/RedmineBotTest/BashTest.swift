import XCTest
import Foundation
import PathKit
@testable import RedmineBotCore

class BashTest: XCTestCase {
    
    func test__createFolderAndFile__shouldGotOutputIsFileName() {
        try? Path("/tmp/RedminBot-testing").mkdir()
        try? Path("/tmp/RedminBot-testing/test-file").write("test")
        
        let sut = Bash()
        
        Path.current = Path("/tmp/RedminBot-testing")
        let output = sut.run("ls", arguments: nil)

        XCTAssertTrue(output == "test-file\n")
    }
    
}

