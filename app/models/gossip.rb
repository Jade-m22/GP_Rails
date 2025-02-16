class Gossip < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { in: 3..20, message: "doit contenir entre 3 et 20 caractères" }
  validates :content, presence: true
end
