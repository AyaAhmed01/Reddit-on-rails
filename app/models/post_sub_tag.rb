class PostSubTag < ApplicationRecord
    validates :post_id, uniqueness: {scope: :sub_id}
    validates :sub, :post, presence: true   # auto validated in Rails > 4
    
    belongs_to :sub 
    belongs_to :post 
end