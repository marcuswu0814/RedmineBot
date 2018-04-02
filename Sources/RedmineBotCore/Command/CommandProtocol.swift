import Commander

public protocol CommandProtocol {
    
    static func make() -> CommandType
    
}
