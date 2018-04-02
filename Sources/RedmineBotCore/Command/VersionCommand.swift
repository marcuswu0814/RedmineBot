import Commander

public class VersionCommand: CommandProtocol {
    
    public static func make() -> CommandType {
        
        let versionCommand = command {
            let action = VersionCommandAction()
            
            action.doAction()
        }
        
        return versionCommand
    }
    
}

class VersionCommandAction {

    lazy var version: VersionProtocol = Version()
    lazy var system: SystemProtocol = System()

    func doAction() {
        system.printNormal(version.string())
    }
    
}
