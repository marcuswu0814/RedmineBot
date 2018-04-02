// See: https://bugs.swift.org/browse/SR-2866
// Currently, we can't use resource by bundle or any other ways.
// So temporary using this class for default template.

import Foundation

struct DefaultTemplate {
    
    public static func comment() -> String {
        let template =
        """
        {{ content }}

        <br><br>

        <b>Send from {{ authorName }} @ RedmineBot</b>
        """
        
        return template
    }

}
