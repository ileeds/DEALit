json.extract! home, :id, :user_id, :address, :price, :description, :size, :start_date, :end_date, :total_bathrooms, :private_bathrooms, :total_rooms, :available_rooms, :is_furnished, :created_at, :updated_at
json.url home_url(home, format: :json)
