puts 'Start inserting post seeds...'

User.limit(10).each do |user|
  rand(0..3).times.each do
    user.posts.create!(body: Faker::JapaneseMedia::StudioGhibli.quote, remote_images_urls: %w[https://picsum.photos/350/350/?random https://picsum.photos/350/350/?random])
  end
end

puts 'Finish inserting post seeds'
