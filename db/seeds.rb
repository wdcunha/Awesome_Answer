# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Answer.destroy_all #order here matters
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

questions.each do |question|
  rand(0..5).times.each do
    Answer.create(
      body: Faker::TheFreshPrinceOfBelAir.quote,
      question: question
    )
  end
end

answers = Asnwer.all

puts Cowsay.say("Created #{answers.count} answers", :moose)
