import Foundation
import Commander
import PathKit
import Rainbow

public class SetupCommand: CommandProtocol {
    
    public static func make() -> CommandType {
        let setupCommand = command(Argument<String>("redmineUrl", description: "Your redmine server URL"),
                                   Argument<String>("apiAccessKey", description: "Your access key from account setting")
        ) { (redmineUrl, apiAccessKey) in
            let action = SetupCommandAction(Config(redmineUrl: redmineUrl, apiAccessKey: apiAccessKey),
                                            configPath: Path.redmineConfig(),
                                            defaultTemplatePath: Path.commentTemplate())
            
            action.doAction()
        }
        
        return setupCommand
    }
    
}

class SetupCommandAction {
    
    lazy var system: SystemProtocol = {
        return System()
    }()
    var config: Config
    var configPath: Path
    var defaultTemplatePath: Path
    
    init(_ config: Config, configPath: Path, defaultTemplatePath: Path) {
        self.config = config
        self.configPath = configPath
        self.defaultTemplatePath = defaultTemplatePath
    }
    
    func doAction() {
        setupConfig()
        setupDefaultTemplate()
        checkSetupFileExist()
    }
    
    private func setupConfig() {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        guard let encodeData = try? jsonEncoder.encode(config) else {
            system.printFatalError("Config encode to json fail.")
        }
        
        guard let encodeString = String(data: encodeData, encoding: .utf8) else {
            system.printFatalError("Data encode to json string fail.")
        }
        
        do {
            try configPath.write(encodeString)
        } catch {
            system.printFatalError("Witre config file to path \(configPath) fail.")
        }
    }
    
    private func setupDefaultTemplate() {
        do {
            try defaultTemplatePath.write(DefaultTemplate.comment())
        } catch {
            system.printFatalError("Create default template file to path \(defaultTemplatePath) fail.")
        }
    }
    
    private func checkSetupFileExist() {
        if defaultTemplatePath.exists && configPath.exists {
            system.printSuccess("Setup success!")
        }
    }

}
