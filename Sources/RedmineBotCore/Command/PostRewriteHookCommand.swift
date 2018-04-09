import Foundation
import PathKit
import Commander

public class PostRewriteHookCommand: CommandProtocol {
    
    public static func make() -> CommandType {
        let postRewriteHookCommand = command {
            let action = PostRewriteHookCommandAction()
            
            action.doAction()
        }
        
        return postRewriteHookCommand
    }
    
}

struct CommitDiff {
    var oldHash: String
    var newHash: String
}

class PostRewriteHookCommandAction {
    
    lazy var provider = CommitsDiffReader()
    lazy var git: GitProtocol.Type = Git.self
    lazy var system: SystemProtocol = System()
    lazy var request = CommentRequest.defaultRequest()
    
    func doAction() {
        let commitsDiff = provider.commitsDiff()
        
        commitsDiff.forEach { commitDiff in
            guard let issuesNumber = processIssuesNumber(commitDiff) else {
                return
            }
            
            let context = CommentContext(content: commitMessage(commitDiff),
                                         authorName: authorName(commitDiff))
            
            issuesNumber.forEach({ issueNumber in
                request.send(to: issueNumber, wtih: context)
            })
        }
    }
    
    private func commitMessage(_ commitDiff: CommitDiff) -> String {
        guard let commitMessage = git.commitMessage(commitDiff.newHash) else {
            system.printFatalError("Ran `git show` fail with sha \(commitDiff.newHash)")
        }
        
        return commitMessage
    }
    
    private func authorName(_ commitDiff: CommitDiff) -> String {
        guard let authorName = git.authorName(commitDiff.newHash) else {
            system.printFatalError("Ran `git show` fail with sha \(commitDiff.newHash)")
        }
        
        return authorName
    }
    
    private func processIssuesNumber(_ commitDiff: CommitDiff) -> [Int]? {
        guard let issuesNumber = git.commitTitle(commitDiff.newHash)?.findIssuesNumber() else {
            return nil
        }
        
        // Remove issue string's `#`, i.g. #12345 -> 12345
        return issuesNumber.map { Int($0.dropFirst())! }
    }
    
}

class CommitsDiffReader {
    
    public func commitsDiff() -> [CommitDiff] {
        var commitsDiff = [CommitDiff]()
        
        while let string = readLine() {
            let hashSplit = string.split(separator: " ").map{ String($0) }
            
            let commitDiff = CommitDiff(oldHash: hashSplit[0], newHash: hashSplit[1])
            
            commitsDiff.append(commitDiff)
        }
        
        return commitsDiff
    }
    
}
