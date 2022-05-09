puts 'Start inserting user seeds ...'

User.create!(email: 'test001@example.com', password: 'password')
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password'
  )
end

puts 'Finish inserting user seeds!'
