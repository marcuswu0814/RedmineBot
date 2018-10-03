import XCTest
import Foundation
import PathKit
import SwiftCLIToolbox
@testable import RedmineBotCore

class BashTest: XCTestCase {
    
    static let testDirPath = Path("/tmp/RedminBot-testing")
    static let testFilePath = Path("/tmp/RedminBot-testing") + Path("test-file")

    override class func setUp() {
        super.setUp()
        
        try? testDirPath.mkdir()
        try? testFilePath.write("test")
        
        Path.current = testDirPath
    }
    
    func test__createFolderAndFile__shouldGotOutputIsFileName() {
        let output = Bash.run("ls", arguments: nil)

        XCTAssertTrue(output == "test-file\n")
    }
    
    override class func tearDown() {
        try? testDirPath.delete()
        
        super.tearDown()
    }
    
}
