class User < ApplicationRecord
  has_many :gossips
  has_many :sent_messages, class_name: "PrivateMessage", foreign_key: "sender_id"
  has_and_belongs_to_many :received_messages, class_name: "PrivateMessage", join_table: "private_messages_users"
  belongs_to :city
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end
end
