import Foundation

extension String {
    
    public func findIssuesNumber() -> [String]? {
        guard let matches = self.regex("\\#[0-9]{1,}") else {
            return nil
        }
        
        return Array(Set(matches))
    }
    
}
