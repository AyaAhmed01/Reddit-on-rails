class Sub < ApplicationRecord
    validates :title, presence: true 
    belongs_to :moderator,
        class_name: 'User'

    has_many :posts
end