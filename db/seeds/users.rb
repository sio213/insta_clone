puts 'Start inserting user seeds ...'

User.create!(username: 'test user001', email: 'test001@example.com', password: 'password')
10.times do
  User.create!(
    username: Faker::Internet.unique.user_name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

puts 'Finish inserting user seeds!'
