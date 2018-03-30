import Commander
import PathKit
import Foundation
import Rainbow

class CommanderFactory {
    
    public static func setup() -> CommandType {
        let setupCommand = command(Argument<String>("redmineUrl", description: "Your redmine server URL"),
                                   Argument<String>("apiAccessKey", description: "Your access key from account setting")
        ) { (redmineUrl, apiAccessKey) in
            let config = Config(redmineUrl: redmineUrl, apiAccessKey: apiAccessKey)
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            
            guard let encodeData = try? jsonEncoder.encode(config) else {
                print("Encode config data error.")

                return
            }
            
            guard let encodeString = String(data: encodeData, encoding: .utf8) else {
                print("Encode config data to json string error.")

                return
            }

            let redmineConfigPath = Path.redmineConfig()
            
            do {
                try redmineConfigPath.write(encodeString)
            } catch {
                print("Write config file error.")
                print(error)
            }
            
            let commentTemplatePath = Path.commentTemplate()
            
            if (!commentTemplatePath.exists) {
                do {
                    try commentTemplatePath.write(DefaultTemplate.comment())
                } catch {
                    print("Default template create error.")
                    print(error)
                }
            }
            
            if commentTemplatePath.exists && redmineConfigPath.exists {
                print("Setup success! 🎉🎉".green)
            }
        }
        
        return setupCommand
    }
    
    public static func comment() -> CommandType {
        let commentCommand = command(Argument<Int>("issueNumber", description: "Comment to issue"),
                                     Argument<String>("authorName", description: "Commit author name"),
                                     Argument<String>("content", description: "Message content")
        ) { (issueNumber, authorName, content) in
            let redmineConfigPath = Path.redmineConfig()
            
            guard let redmineConfig = try? redmineConfigPath.read() else {
                print("Load config fail")
                
                return
            }

            let jsonDecoder = JSONDecoder()
            
            guard let config = try? jsonDecoder.decode(Config.self, from: redmineConfig) else {
                return
            }
            
            let request = CommentRequest(config)
            request.send(to: issueNumber, wtih: CommentContext(content: content,
                                                               authorName: authorName))
        }
        
        return commentCommand
    }
    
}
