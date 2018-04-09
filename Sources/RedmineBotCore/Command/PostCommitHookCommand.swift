import Foundation
import Commander
import PathKit

public class PostCommitHookCommand: CommandProtocol {
    
    public static func make() -> CommandType {        
        let postCommitHookCommand = command {
            let action = PostCommitHookCommandAction()
            
            action.doAction()
        }
        
        return postCommitHookCommand
    }
    
}

class PostCommitHookCommandAction {
    
    lazy var system: SystemProtocol = System()
    lazy var git: GitProtocol.Type = Git.self
    lazy var request = CommentRequest.defaultRequest()
    
    func doAction() {
        guard let commitLog = git.commitMessage("") else {
            return
        }
        
        let authorName = git.authorName("") ?? "No author name"
        
        let issuesNumber = processIssuesNumber()
        
        issuesNumber?.forEach({ issueNumber in
            let context = CommentContext(content: commitLog,
                                         authorName: authorName)
            
            request.send(to: issueNumber, wtih: context)
        })
    }
    
    private func processIssuesNumber() -> [Int]? {
        guard let issuesNumber = git.commitTitle("")?.findIssuesNumber() else {
            return nil
        }
        
        // Remove issue string's `#`, i.g. #12345 -> 12345
        return issuesNumber.map { Int($0.dropFirst())! }
    }
    
}
