# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'


Like.destroy_all
Comment.destroy_all
PrivateMessage.destroy_all
GossipTag.destroy_all
Gossip.destroy_all
Tag.destroy_all
User.destroy_all
City.destroy_all


# Création des villes
10.times do
  City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

# Création des utilisateurs
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.email,
    age: rand(18..60),
    city_id: City.all.sample.id
  )
end

# Création des gossips
20.times do
  Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user: User.all.sample
  )
end

# Création des tags
10.times do
  Tag.create!(title: "##{Faker::Lorem.word}")
end

# Association des tags aux gossips
Gossip.all.each do |gossip|
  gossip.tags << Tag.all.sample(rand(1..3))
end

# Création des commentaires
20.times do
  Comment.create!(
    content: Faker::Lorem.sentence,
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end

# Création des likes (sur commentaires et gossips)
20.times do
  Like.create!(
    user: User.all.sample,
    likeable: [ Gossip.all.sample, Comment.all.sample ].sample
  )
end

# Création des messages privés
5.times do
  sender = User.all.sample
  recipients = User.all.sample(rand(1..3))

  pm = PrivateMessage.create!(
    content: Faker::Lorem.sentence,
    sender: sender
  )

  pm.recipients << recipients
end
puts "Tout fonctionne !!!"