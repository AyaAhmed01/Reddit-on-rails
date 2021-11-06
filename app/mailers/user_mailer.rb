class UserMailer < ApplicationMailer
    default from: "Reddit <noreply@reddit.com>"

    def activation_email(user)
        @user = user 
        @first_name = @user.user_name.split(' ').first
        @activation_url = activate_users_url(activation_token: @user.activation_token) 
        mail(to: "#{@user.user_name} <#{@user.email}>", subject: "Verify your Reddit email address")
    end
end
