class Post < ApplicationRecord
    validates :title, presence: true 

    belongs_to :sub 
    belongs_to :author, 
        class_name: 'User'
end