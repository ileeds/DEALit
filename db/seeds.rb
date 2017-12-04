# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("users")

User.create!(name: "Tester", email: "test@test.com", password: "password", notification_type: "email")

5.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, notification_type: "email")
end

locations = GeoSeeder::Location.random({
  center: "02453",
  radius: 2,
  quantity: 10
})

@images = Dir.glob("#{Rails.root}/app/assets/images/home_samples/*.jpeg")

locations.each do |location|
  start_date = Date.today
  end_date = Faker::Date.between(start_date + 1.year, start_date + 2.years)
  home = Home.create(
    user_id: 1, notification_id: nil, title: Faker::Company.bs, description: Faker::Company.bs, address: [location.street_number + ' ' + location.street, location.city, location.state].join(", "),
    price: Faker::Number.decimal(3, 2), start_date: start_date, end_date: end_date, capacity: Faker::Number.between(1, 10),
    total_rooms: Faker::Number.between(1, 10), available_rooms: Faker::Number.between(1, 10),
    total_bathrooms: Faker::Number.between(1, 10), private_bathrooms: Faker::Number.between(1, 10), is_furnished: Faker::Boolean,
    latitude: location.lat, longitude: location.lng, entire_home: Faker::Boolean, status: "active"
  )
  3.times do
    Photo.create(
      photo: File.new(@images.sample), home_id: home.id
    )
  end
end
