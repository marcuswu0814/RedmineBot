import Foundation
import Commander
import PathKit

extension Config {
    
    static func readFromPath(_ path: Path) -> Config {
        guard let redmineConfig = try? path.read() else {
            System.fatalError("Load config file fail.")
        }
        
        let jsonDecoder = JSONDecoder()
        
        guard let config = try? jsonDecoder.decode(Config.self, from: redmineConfig) else {
            System.fatalError("Config file JSON decode fail.")
        }
        
        return config
    }
    
}

class CommentCommand: CommandProtocol {
    
    static func make() -> CommandType {
        let commentCommand = command(Argument<Int>("issueNumber", description: "Comment to issue"),
                                     Argument<String>("authorName", description: "Commit author name"),
                                     Argument<String>("content", description: "Message content")
        ) { (issueNumber, authorName, content) in
            let config = Config.readFromPath(Path.redmineConfig())
            let request = CommentRequest(config)
            let action = CommentCommandAction(issueNumber,
                                              context: CommentContext(content: content,
                                                                      authorName: authorName),
                                              request: request)
            action.doAction()
        }
        
        return commentCommand
    }
    
}

class CommentCommandAction {
    
    let request: CommentRequest
    let issueNumber: Int
    let context: CommentContext

    init(_ issueNumber: Int,
         context: CommentContext,
         request: CommentRequest) {
        self.request = request
        self.issueNumber = issueNumber
        self.context = context
    }
    
    func doAction() {
        request.send(to: issueNumber, wtih: context)
    }
    
}
