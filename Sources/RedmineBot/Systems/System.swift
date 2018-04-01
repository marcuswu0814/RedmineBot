struct System {
    
    static func printSuccess(_ string: String) {
        print(string.green)
    }
    
    static func printWarning(_ string: String) {
        print("⚠️" + string.yellow)
    }
    
    static func fatalError(_ string: String) -> Never {
        fatalError("💥" + string.red)
    }
    
}
