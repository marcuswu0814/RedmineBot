import Foundation
import Commander
import PathKit

public class UninstallHookCommand: CommandProtocol {
    
    public static func make() -> CommandType {
        let uninstallCommand = command {
            let action = UnInstallHookCommandAction()
            
            action.doAction()
        }
        
        return uninstallCommand
    }
    
}

enum UninstallHookCommandActionError: Error {
    case gitRepoNotExist
    case deleteHookFileFail
}

class UnInstallHookCommandAction {
    
    lazy var system: SystemProtocol = System()
    
    lazy var postCommitHookJob = HookInstallJob(repoPath: Path.current + Path(".git"),
                                                hookName: "post-commit",
                                                hookContent: DefaultTemplate.postCommitHook())
    lazy var postRewriteHookJob = HookInstallJob(repoPath: Path.current + Path(".git"),
                                                 hookName: "post-rewrite",
                                                 hookContent: DefaultTemplate.postRewriteHook())
    
    func doAction() {
        let uninstaller = HookUninstaller(system)
        
        do {
            try uninstaller.uninstall([postCommitHookJob, postRewriteHookJob])
        } catch {
            system.printFatalError(error.localizedDescription)
        }
    }
}

class HookUninstaller {
    
    var system: SystemProtocol
    
    init(_ system: SystemProtocol) {
        self.system = system
    }
    
    func uninstall(_ jobs: [HookInstallJob]) throws {
        for job in jobs {
            try checkRepoExist(job)
            try uninstallHook(to: job.hookPath, hookContent: job.hookContent)
        }
    }
    
    private func checkRepoExist(_ job: HookInstallJob) throws {
        if (!job.repoPath.exists) {
            throw UninstallHookCommandActionError.gitRepoNotExist
        }
    }
    
    private func uninstallHook(to path: Path, hookContent: String) throws {
        if (path.exists) {
            try deleteExistHook(to: path)
        } else {
            system.printWarning("The file \(path.absolute()) is not exists.")
        }
    }
    
    private func deleteExistHook(to path: Path) throws {
        do {
            try path.delete()
        } catch {
            throw UninstallHookCommandActionError.deleteHookFileFail
        }
        system.printWarning("Hook \(path.lastComponent) uninstall to path \(path) success.")
    }
    
}
