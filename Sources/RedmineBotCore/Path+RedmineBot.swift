import PathKit

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
    
    public static func commentTemplate() -> Path {
        return configFolder() + Path("Comment.template")
    }
    
    public static func redmineConfig() -> Path {
        return configFolder() + Path("redmineConfig")
    }
    
}
