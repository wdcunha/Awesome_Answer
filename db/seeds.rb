# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Question.destroy_all

100.times do
  Question.create(
    title: Faker::Seinfeld.quote,
    body: Faker::HitchhikersGuideToTheGalaxy.quote,
    view_count: rand(1..1000)
  )
end

questions = Question.all

puts Cowsay.say("Created #{questions.count} questions", :ghostbusters)