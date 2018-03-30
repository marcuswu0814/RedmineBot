import Commander
import Foundation

let version = "0.0.1"

Group {
    
    $0.addCommand("setup", CommanderFactory.setup())
    $0.addCommand("comment", CommanderFactory.comment())
    
}.run()
