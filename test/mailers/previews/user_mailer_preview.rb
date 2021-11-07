# Preview activation_emails at http://localhost:3000/rails/mailers/user_mailer/activation_email?email=user@example.com
class UserMailerPreview < ActionMailer::Preview
    def activation_email
        user = User.find_by(email: params[:email]) 
        UserMailer.activation_email(user)
    end
end

