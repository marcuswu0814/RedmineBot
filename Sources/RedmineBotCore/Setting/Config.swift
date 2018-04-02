import Foundation
import PathKit

struct Config: Codable {
    let redmineUrl: String
    let apiAccessKey: String
}

extension Config {
    
    static func readFromPath(_ path: Path) -> Config {
        guard let redmineConfig = try? path.read() else {
            System().printFatalError("Load config file fail.")
        }
        
        let jsonDecoder = JSONDecoder()
        
        guard let config = try? jsonDecoder.decode(Config.self, from: redmineConfig) else {
            System().printFatalError("Config file JSON decode fail.")
        }
        
        return config
    }
    
}
