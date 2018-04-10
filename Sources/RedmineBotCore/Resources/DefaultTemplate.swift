// See: https://bugs.swift.org/browse/SR-2866
// Currently, we can't use resource by bundle or any other ways.
// So temporary using this class for default template.

import Foundation

struct DefaultTemplate {
    
    static func comment() -> String {
        let template =
        """
        {{ authorName }} commit{% if repoName %} @ repo: {{ repoName }} {% endif %} {% if branchName %} & branch {{ branchName }} {% endif %}

        <br><br>

        {{ content }}

        <br>

        <b>Send from <a href="https://github.com/marcuswu0814/RedmineBot">RedmineBot</a></b>
        """
        
        return template
    }
    
    static func postCommitHook() -> String {
        let hook =
        """
        redmine-bot post-commit-hook
        """
        
        return hook
    }
    
    static func postRewriteHook() -> String {
        let hook =
        """
        redmine-bot post-rewrite-hook
        """
        
        return hook
    }
    
}
