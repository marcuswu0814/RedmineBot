public protocol SystemProtocol {
    
    func printNormal(_ string: String)
    
    func printSuccess(_ string: String)
    
    func printWarning(_ string: String)
    
    func printFatalError(_ string: String) -> Never
    
}

public struct System: SystemProtocol {
    
    public func printNormal(_ string: String) {
        print(string)
    }
    
    public func printSuccess(_ string: String) {
        print(string.green)
    }
    
    public func printWarning(_ string: String) {
        print("⚠️" + string.yellow)
    }
    
    // Swift bug: https://bugs.swift.org/browse/SR-2729
    // Compiler warning `Will never be executed`/
    public func printFatalError(_ string: String) -> Never  {
        fatalError("💥" + string.red)
    }
  
}
