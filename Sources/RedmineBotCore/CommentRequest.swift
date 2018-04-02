import Foundation
import Alamofire
import Stencil
import PathKit

struct CommentContext {
    let content: String
    let authorName: String
}

class CommentRequest: NSObject {
    
    var config: Config
    
    var runner = SwiftScriptRunner()
    
    init(_ config: Config) {
        self.config = config
    }
    
    public func send(to issueNumber: Int, wtih context: CommentContext) {
        runner.lock()
        
        let context = [
            "content": context.content,
            "authorName": context.authorName
        ]
        
        let path = Path.configFolder()
        let environment = Environment(loader: FileSystemLoader(paths: [path]))
        let rendered = try? environment.renderTemplate(name: "Comment.template", context: context)
        
        guard let commentInfo = rendered else {
            print("Rendered error! Check your template file first. 🙏".red)
            
            return
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
                    print("Got some error. 🙇".red)
                    print("\n\(error)")
                } else {
                    print("Comment send success! 🎉🎉".green)
                }
                
                self.runner.unlock()
        }
        
        runner.wait()
    }
    
}
