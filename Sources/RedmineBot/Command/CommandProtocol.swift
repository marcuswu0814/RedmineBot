import Commander

protocol CommandProtocol {
    
    static func make() -> CommandType
    
}
