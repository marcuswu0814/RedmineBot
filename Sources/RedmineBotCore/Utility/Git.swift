import Foundation

public protocol GitProtocol {
    
    static func authorName(_ sha: String) -> String?
    
    static func commitTitle(_ sha: String) -> String?

    static func commitMessage(_ sha: String) -> String?
    
    static func repoName() -> String?
    
    static func branchName() -> String?
    
}

public struct Git: GitProtocol {
   
    public static func repoName() -> String? {
        guard let repoPath = Bash.run("git", arguments: ["rev-parse", "--show-toplevel"]) else {
            return nil
        }
        
        return Bash.run("basename", arguments: [repoPath])?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public static func branchName() -> String? {
        return Bash.run("git", arguments: ["rev-parse", "--abbrev-ref", "HEAD"])?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public static func authorName(_ sha: String) -> String? {
        return Bash.run("git", arguments: ["show", sha, "--quiet", "--pretty=format:%an"])
    }
    
    public static func commitTitle(_ sha: String) -> String? {
        return Bash.run("git", arguments: ["show", sha, "--oneline", "--quiet"])
    }

    public static func commitMessage(_ sha: String) -> String? {
        return Bash.run("git", arguments: ["show", sha, "--quiet"])
    }
    
}
