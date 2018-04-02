import Foundation
import Commander
import PathKit

public class CommentCommand: CommandProtocol {
    
    public static func make() -> CommandType {
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
