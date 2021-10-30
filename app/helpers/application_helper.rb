module ApplicationHelper
    def auth_token_helper 
        "<input type=\"hidden\" name=\"authenticity_token\" value=\"<%=#{form_authenticity_token}%>\">".html_safe
    end

    def comment_link_helper(comment)
        content = comment.content
        if content.length > 20
            text = "#{content[0..20]}..."
        else
            text = "#{content}"
        end
        text.html_safe
    end
end
