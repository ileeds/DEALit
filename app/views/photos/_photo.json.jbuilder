json.extract! photo, :id, :filename, :created_at, :updated_at
json.url photo_url(photo, format: :json)
