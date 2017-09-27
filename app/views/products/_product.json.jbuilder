json.extract! product, :id, :user_id, :address, :price, :description, :size, :start_date, :end_date, :bathrooms, :total_rooms, :rooms_available, :is_furnished, :created_at, :updated_at
json.url product_url(product, format: :json)
