class User < ApplicationRecord
  has_many :sent_messages, class_name: "PrivateMessage", foreign_key: "sender_id"
  has_and_belongs_to_many :received_messages, class_name: "PrivateMessage", join_table: "private_messages_users"
  belongs_to :city
end
