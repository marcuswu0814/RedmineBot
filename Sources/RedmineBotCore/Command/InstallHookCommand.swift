import Foundation
import Commander
import PathKit

public class InstallHookCommand: CommandProtocol {
    
    public static func make() -> CommandType {
        let installCommand = command {
            let action = InstallHookCommandAction()
            
            action.doAction()
        }
        
        return installCommand
    }
    
}

enum InstallHookCommandActionError: Error {
    case openExistsFileFail
    case createHookFileFail
    case updateHookFileFail
}

class InstallHookCommandAction {
    
    lazy var system: SystemProtocol = System()
    lazy var postCommitHook = DefaultTemplate.postCommitHook()
    lazy var postRewriteHook = DefaultTemplate.postRewriteHook()
    
    private(set) lazy var postCommitHookPath = gitHooksDirPath + Path("post-commit")
    private(set) lazy var postRewriteHookPath = gitHooksDirPath + Path("post-rewrite")
    
    private let pwd = Path.current
    private lazy var gitRepoPath = pwd + Path(".git")
    private lazy var gitHooksDirPath = gitRepoPath + Path("hooks")
    
    func doAction() {
        checkGitRepo()
        installPostCommitHook()
        installPostWriteHook()
    }
    
    private func checkGitRepo() {
        if !gitRepoPath.exists {
            System().printFatalError("Not a git repository.")
        }
    }
    
    private func installPostCommitHook() {
        do {
            try installHook(to: postCommitHookPath, hookContent: postCommitHook)
        } catch {
            system.printFatalError(error.localizedDescription)
        }
    }
    
    private func installPostWriteHook() {
        do {
            try installHook(to: postRewriteHookPath, hookContent: postRewriteHook)
        } catch {
            system.printFatalError(error.localizedDescription)
        }
    }
    
    private func installHook(to path: Path, hookContent: String) throws {
        if (path.exists) {
            guard let file: String = try? path.read() else {
                throw InstallHookCommandActionError.openExistsFileFail
            }
            
            if file.range(of: hookContent) != nil {
                system.printWarning("Hook \(path.lastComponent) already installed.")
            } else {
                let appendedPostCommit = file + "\n\n" + hookContent
                
                do {
                    try postCommitHookPath.write(appendedPostCommit)
                } catch {
                    throw InstallHookCommandActionError.updateHookFileFail
                }
            }
        } else {
            do {
                try path.write(hookContent)
            } catch {
                throw InstallHookCommandActionError.createHookFileFail
            }
            
            path.chmod("755")
            system.printSuccess("Hook \(path.lastComponent) install to path \(path) success.")
        }
    }
    
}
