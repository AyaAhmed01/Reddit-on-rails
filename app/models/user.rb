class User < ApplicationRecord
    attr_reader :password
    
    after_initialize :ensure_session_token

    validates :user_name, :password_digest, :session_token, presence: true 
    validates :user_name, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :subs,                    # subs that user moderate
        foreign_key: :moderator_id,
        class_name: 'Sub'

    has_many :posts, 
        foreign_key: :author_id,
        class_name: 'Post'
    
    has_many :comments,
        foreign_key: :author_id,
        class_name: 'Comment'

    has_many :subscriptions,
        dependent: :destroy, 
        inverse_of: :user 

    has_many :subscribed_subs,
        through: :subscriptions, 
        source: :sub

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        user.try(:is_password?, password) ? user : nil 
    end

    def self.generate_session_token
        begin 
        token = SecureRandom.urlsafe_base64(16)
        end while User.exists?(session_token: token)
        token  
    end

    def subscribed?(sub)
        self.subscribed_subs.include?(sub)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)        
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end
end