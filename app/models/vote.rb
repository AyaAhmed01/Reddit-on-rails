class Vote < ApplicationRecord
    validates :value, presence: true
    belongs_to :votable, polymorphic: true 
end