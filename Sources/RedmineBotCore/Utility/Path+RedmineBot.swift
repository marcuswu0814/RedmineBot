import PathKit
import SwiftCLIToolbox

extension Path {
    
    public static func configFolder() -> Path {
        let configFolder = Path.home + Path(".RedmineBot")
        
        if (!configFolder.exists) {
            do {
                try configFolder.mkdir()
            } catch {
                print("Create config folder fail.")
                print(error)
            }
        }
        
        return configFolder
    }
    
    public static func redmineConfig() -> Path {
        return configFolder() + Path("redmineConfig")
    }
    
}

extension Path {
    
    public func chmod(_ mode: String) {
        _ = Bash.run("chmod", arguments: [mode, self.string])
    }
    
}
