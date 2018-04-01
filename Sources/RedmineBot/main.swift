import Commander
import Foundation

let version = "0.0.1"

Group {
    
    $0.addCommand("setup", SetupCommand.make())
    $0.addCommand("comment", CommentCommand.make())
    
}.run()
