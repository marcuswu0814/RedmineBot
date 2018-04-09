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
    case gitRepoNotExist
    case openExistsFileFail
    case createHookFileFail
    case updateHookFileFail
}

class InstallHookCommandAction {
    
    lazy var system: SystemProtocol = System()
    
    lazy var postCommitHookJob = HookInstallJob(repoPath: Path.current + Path(".git"),
                                                hookName: "post-commit",
                                                hookContent: DefaultTemplate.postCommitHook())
    lazy var postRewriteHookJob = HookInstallJob(repoPath: Path.current + Path(".git"),
                                                 hookName: "post-rewrite",
                                                 hookContent: DefaultTemplate.postRewriteHook())
    
    func doAction() {
        let installer = HookInstaller(system)
        
        do {
            try installer.install([postCommitHookJob, postRewriteHookJob])
        } catch {
            system.printFatalError(error.localizedDescription)
        }
    }
    
}

struct HookInstallJob {
    
    let repoPath: Path
    let hookName: String
    let hookContent: String
    
    var hookDirPath: Path {
        return repoPath + Path("hooks")
    }
    
    var hookPath: Path {
        return hookDirPath + Path(hookName)
    }
    
}

class HookInstaller {
    
    var system: SystemProtocol
    
    init(_ system: SystemProtocol) {
        self.system = system
    }
    
    func install(_ jobs: [HookInstallJob]) throws {
        for job in jobs {
            try checkRepoExist(job)
            try installHook(to: job.hookPath, hookContent: job.hookContent)
        }
    }
    
    private func checkRepoExist(_ job: HookInstallJob) throws {
        if (!job.repoPath.exists) {
            throw InstallHookCommandActionError.gitRepoNotExist
        }
    }
    
    private func installHook(to path: Path, hookContent: String) throws {
        if (path.exists) {
            try appendToExistHook(to: path, hookContent: hookContent)
        } else {
            try createHookFile(to: path, hookContent: hookContent)
        }
    }
    
    private func appendToExistHook(to path: Path, hookContent: String) throws {
        guard let file: String = try? path.read() else {
            throw InstallHookCommandActionError.openExistsFileFail
        }
        
        if file.range(of: hookContent) != nil {
            system.printWarning("Hook \(path.lastComponent) already installed.")
        } else {
            let appendedPostCommit = file + "\n\n" + hookContent
            
            do {
                try path.write(appendedPostCommit)
            } catch {
                throw InstallHookCommandActionError.updateHookFileFail
            }
        }
    }
    
    private func createHookFile(to path: Path, hookContent: String) throws {
        do {
            try path.write(hookContent)
        } catch {
            throw InstallHookCommandActionError.createHookFileFail
        }
        
        path.chmod("755")
        system.printSuccess("Hook \(path.lastComponent) install to path \(path) success.")
    }
    
}
