puts 'Start inserting post seeds...'

User.limit(5).each do |user|
  user.posts.create!(body: Faker::JapaneseMedia::StudioGhibli.quote)
end

puts 'Finish inserting post seeds'
