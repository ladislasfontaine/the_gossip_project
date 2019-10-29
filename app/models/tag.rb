class Tag < ApplicationRecord
  validates :tag,
    presence: true

  has_many :gossip_tags
  has_many :gossips, through: :gossip_tags
end
