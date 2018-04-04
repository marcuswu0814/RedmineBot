import Foundation

extension String {
    
    public func regex(_ pattern: String) -> [String]? {
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch {
            return nil
        }
    }
    
}
