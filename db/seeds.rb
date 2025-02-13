require 'faker'
require 'faussaire'

# Suppression des anciennes données
Like.destroy_all
Comment.destroy_all
PrivateMessage.destroy_all
GossipTag.destroy_all
Gossip.destroy_all
Tag.destroy_all
User.destroy_all
City.destroy_all

puts "📌 Base de données vidée."

#villes
30.times do
  City.create!(
    name: Faussaire::Address.city,
    zip_code: Faussaire::Address.postal_code
  )
end

puts "🏙️ 30 villes créées."

#utilisateurs
20.times do
  first_name = rand(2).zero? ? Faussaire::Name.female_first_name : Faussaire::Name.male_first_name

  User.create!(
    first_name: first_name,
    last_name: Faussaire::Name.family_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.unique.email,
    age: rand(18..60),
    city: City.all.sample,
    password: "password"
  )
end

puts "🧑‍🤝‍🧑 20 utilisateurs créés."

#gossips
25.times do
  Gossip.create!(
    title: Faker::Lorem.characters(number: (3..14)),
    content: Faussaire::Piraterie.potin,
    user: User.all.sample
  )
end

puts "📝 25 gossips créés."

#tags
10.times do
  Tag.create!(
    title: Faussaire::Piraterie.rage
  )
end

puts "🏷️ 10 tags créés."

# Association des tags aux gossips
Gossip.all.each do |gossip|
  gossip.tags << Tag.all.sample(rand(1..3))
end

puts "🔗 Les gossips ont été tagués."

#commentaires
20.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 8),
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end

puts "💬 20 commentaires créés."

#likes
20.times do
  Like.create!(
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end

puts "❤️ 20 likes créés."

# Création des messages privés
5.times do
  sender = User.all.sample
  recipients = User.all.sample(rand(1..3))

  pm = PrivateMessage.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    sender: sender
  )

  pm.recipients << recipients
end

puts "📩 5 messages privés créés."

puts "Tout fonctionne !!!"
