class Post < ApplicationRecord
    validates :title, presence: true 
    validates :subs, presence: {message: 'must have at least one sub'}
    
    belongs_to :author, 
        class_name: 'User',
        inverse_of: :posts
    
    has_many :taggings, 
        foreign_key: :post_id, 
        class_name: 'PostSubTag',
        dependent: :destroy,
        inverse_of: :post

    has_many :subs, 
        through: :taggings, 
        source: :sub 
end