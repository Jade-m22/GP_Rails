class Gossip < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
  has_many :likes, as: :likeable

  validates :title, presence: true, length: { in: 3..14, message: "doit contenir entre 3 et 14 caractères" }
  validates :content, presence: true
end
