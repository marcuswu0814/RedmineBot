import Foundation

public protocol BashProtocol {
    
    static func run(_ command: String, arguments: [String]?) -> String?

}

public struct Bash: BashProtocol {
    
    public static func run(_ command: String, arguments: [String]?) -> String? {
        var args = [command]
        
        if let arguments = arguments {
            args.append(contentsOf: arguments)
        }
        
        return shell(launchPath: "/usr/bin/env", arguments: args)
    }

    private static func shell(launchPath: String, arguments: [String]?) -> String? {
        let task = Process()
        task.launchPath = launchPath

        if let args = arguments?.filter({ $0 != "" }) {
            task.arguments = args
        }

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        return output
    }

}
