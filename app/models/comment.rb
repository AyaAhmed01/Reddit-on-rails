class Comment < ApplicationRecord
    validates :content, presence: true
    
    belongs_to :author, 
        class_name: 'User'
    
    belongs_to :post

    has_many :child_comments,
        primary_key: :id,
        foreign_key: :parent_comment_id,
        class_name: 'Comment'

    belongs_to :parent_comment,
        class_name: 'Comment',
        optional: true      # parent_comment_id is null for top-level comments    
end