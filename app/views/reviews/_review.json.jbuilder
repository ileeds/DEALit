json.extract! review, :id, :home_id, :user_id, :description, :created_at, :updated_at
json.url review_url(review, format: :json)