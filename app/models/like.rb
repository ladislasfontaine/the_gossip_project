class Like < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :gossip_id
  belongs_to :user
  belongs_to :gossip
end
