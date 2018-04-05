import Foundation

public protocol GitProtocol {
    
    static func authorName(_ sha: String) -> String?
    
    static func commitTitle(_ sha: String) -> String?

    static func commitMessage(_ sha: String) -> String?
    
}

public struct Git: GitProtocol {
    
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
