User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
GossipTag.destroy_all
PrivateMessage.destroy_all

cities = []
tags = []
users = []
gossips = []

cities_hash = {"Bordeaux" => "33000", "Paris" => "75000", "Lille" => "59000", "Marseille" => "13000", "Lyon" => "69000", "Toulouse" => "31000", "Nice" => "06000", "Nantes" => "44000", "Rennes" => "35000", "Hossegor" => "40150"}
cities_hash.each do |city, zip|
  cities << City.create!(name: city, zip_code: zip)
end

10.times do |index|
  tags << Tag.create!(title: Faker::Hipster.word.capitalize)
  # on crée nos 10 tags et on leur met une majuscule
end

10.times do |index|
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.email,
    age: rand(18..90),
    city: cities.sample
  )
  # on crée nos 10 users et on leur attribue une ville
end

20.times do |index|
  gossips << Gossip.create(
    title: Faker::Lorem.word.capitalize,
    content: Faker::Hipster.paragraph,
    user: users.sample
  )
  # on crée nos 20 gossips et on leur attribue un user
end

gossips.each do |gossip|
  rand(1..3).times do |index|
    GossipTag.create!(gossip: gossip, tag: tags.sample)
  end
  # on lie chacun de nos gossips avec 1, 2 ou 3 tags de façon aléatoire
end

6.times do |index|
  content = Faker::Hipster.sentence
  sender = users.sample
  # on prend un émetteur du message parmi nos users
  recipient_array = users.reject{ |user| user == sender }.sample(rand(1..3))
  # on l'enlève des receveurs, puis on choisit 1, 2 ou 3 receveurs
  # auxquels on envoie le même message
  recipient_array.each do |recipient|
    PrivateMessage.create!(
      content: content,
      sender: sender,
      recipient: recipient
    )
  end
end
