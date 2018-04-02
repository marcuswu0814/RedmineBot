import Commander
import RedmineBotCore

let version = "0.0.1"

Group {
    
    $0.addCommand("setup", SetupCommand.make())
    $0.addCommand("comment", CommentCommand.make())
    $0.addCommand("version", VersionCommand.make())

}.run()
