class Gossip < ApplicationRecord
  validates :title,
    presence: true,
    length: { in: 3..14 }
  validates :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :delete_all
  # méthode qui permet de supprimer les comments associés dans la BDD
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
end
