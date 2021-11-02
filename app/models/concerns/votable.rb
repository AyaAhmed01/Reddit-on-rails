module Votable
    extend ActiveSupport::Concern
    included do
        has_many :votes,
        as: :votable,
        dependent: :destroy
    end

    def votes_score
        self.votes.sum(:value)
    end
end