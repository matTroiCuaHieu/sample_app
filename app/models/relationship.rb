class Relationship < ApplicationRecord
  belongs_to :follower, User.name
  belongs_to :followed, User.name
  
  validates :follower_id, :follower_id, presence: true
end
