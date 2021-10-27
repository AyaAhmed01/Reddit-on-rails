module ApplicationHelper
    def auth_token_helper 
        "<input type=\"hidden\" method=\"authenticity_token\" name=\"%<=form_authenticity_token%>\">".html_safe
    end
end
