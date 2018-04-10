import Foundation
import Alamofire
import Stencil
import PathKit
import HTMLEntities

struct CommentContext {
    let content: String
    let authorName: String
    var gitRepoName: String?
    var gitBranchName: String?
}

class CommentRequest: NSObject {
    
    lazy var system: SystemProtocol = System()
    var config: Config
    var runner = SwiftScriptRunner()
    
    static func defaultRequest() -> CommentRequest {
        let config = Config.readFromPath(Path.redmineConfig())
        
        return CommentRequest(config)
    }
    
    init(_ config: Config) {
        self.config = config
    }
    
    public func send(to issueNumber: Int, wtih context: CommentContext) {
        runner.lock()
        
        let htmlContext = context.content.htmlEscape().replacingOccurrences(of: "\n", with: "<br>")
        
        var templateContext = [
            "content": htmlContext,
            "authorName": context.authorName
        ]
        
        if let branchName = context.gitBranchName {
            templateContext["branchName"] = branchName
        }
        
        if let repoName = context.gitRepoName {
            templateContext["repoName"] = repoName
        }
        
        let template = Template(templateString: DefaultTemplate.comment())
        let rendered = try? template.render(templateContext)
       
        guard let commentInfo = rendered else {
            system.printFatalError("Rendered error. 🙇")
        }
        
        let parameters: Parameters = ["issue": ["notes": commentInfo]]
        let url = config.redmineUrl + "/issues/\(issueNumber).json?key=\(config.apiAccessKey)"
        
        Alamofire.request(url,
                          method: .put,
                          parameters: parameters,
                          encoding: URLEncoding.httpBody)
            .validate(statusCode: 200..<300)
            .responseString { response in
                if let error = response.error {
                    self.system.printWarning("Got some network error. 🙇")
                    self.system.printWarning("Error: \n\(error)")
                } else {
                    self.system.printSuccess("Comment send success!")
                }
                
                self.runner.unlock()
        }
        
        runner.wait()
    }
    
}
