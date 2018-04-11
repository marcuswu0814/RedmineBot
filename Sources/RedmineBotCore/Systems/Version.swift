import Foundation
import PathKit

public protocol VersionProtocol {
    
    var major: Int { get }
    var minor: Int { get }
    var patch: Int { get }
    
    func string() -> String
    
}

extension VersionProtocol {
    
    func string() -> String {
        return "\(major).\(minor).\(patch)"
    }
    
}

struct Version: VersionProtocol {
   
    var major = 0
    var minor = 1
    var patch = 0
    
}

