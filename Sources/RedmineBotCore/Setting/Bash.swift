import Foundation

public struct Bash {
    
    public func run(_ command: String, arguments: [String]?) -> String? {
        var args = [command]
        
        if let arguments = arguments {
            args.append(contentsOf: arguments)
        }
        
        return shell(launchPath: "/usr/bin/env", arguments: args)
    }

    private func shell(launchPath: String, arguments: [String]?) -> String? {
        let task = Process()
        task.launchPath = launchPath

        if let args = arguments {
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
