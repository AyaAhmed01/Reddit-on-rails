class User < ApplicationRecord
    attr_reader :password 
    validates :user_name, :password_digest, :session_token, presence: true 
    validates :user_name, uniqueness: true
    validates :password, length: {minimum: 6}
    before_validation :ensure_session_token

    has_many :subs, 
        foreign_key: :moderator_id,
        class_name: 'Sub'

    has_many :posts, 
        foreign_key: :author_id,
        class_name: 'Post'

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        unless user.nil?
            return (user.is_password?(password) ? user : nil)
        end
        nil 
    end

    def self.generate_session_token
        SecureRandom.urlsafe_base64(16) 
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        # BCrypt::Password.create(password) == BCrypt::Password.new(self.password_digest)
        BCrypt::Password.new(self.password_digest).is_password?(password)        
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
    end
end