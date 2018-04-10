import Commander
import RedmineBotCore

let version = "0.0.1"

Group {
    
    $0.addCommand("setup", SetupCommand.make())
    $0.addCommand("install-hook", InstallHookCommand.make())
    $0.addCommand("version", VersionCommand.make())

    $0.addCommand("post-commit-hook", PostCommitHookCommand.make())
    $0.addCommand("post-rewrite-hook", PostRewriteHookCommand.make())
    
}.run()
