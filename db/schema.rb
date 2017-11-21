# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171117200446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.integer "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "homes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "gallery_id"
    t.integer "notification_id"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.string "address"
    t.float "price"
    t.integer "size"
    t.date "start_date"
    t.date "end_date"
    t.integer "total_rooms"
    t.integer "available_rooms"
    t.float "total_bathrooms"
    t.float "private_bathrooms"
    t.boolean "is_furnished"
    t.float "driving_distance"
    t.integer "driving_duration"
    t.float "bicycling_distance"
    t.integer "bicycling_duration"
    t.float "transit_distance"
    t.integer "transit_duration"
    t.float "walking_distance"
    t.integer "walking_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "details"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.float "size_of_house"
    t.integer "capacity"
    t.boolean "free_parking"
    t.boolean "street_parking"
    t.float "deposit"
    t.float "broker"
    t.boolean "pets"
    t.integer "beds"
    t.boolean "heated"
    t.boolean "ac"
    t.boolean "tv"
    t.boolean "dryer"
    t.boolean "dish_washer"
    t.boolean "fireplace"
    t.boolean "kitchen"
    t.boolean "garbage_disposal"
    t.boolean "wireless"
    t.boolean "lock"
    t.boolean "elevator"
    t.boolean "pool"
    t.boolean "gym"
    t.boolean "wheelchair"
    t.boolean "hot_tub"
    t.boolean "smoking"
    t.boolean "events"
    t.boolean "subletting"
    t.boolean "utilities_included"
    t.float "water_price"
    t.float "heat_price"
    t.boolean "closet"
    t.boolean "porch"
    t.boolean "lawn"
    t.boolean "patio"
    t.boolean "storage"
    t.integer "floors"
    t.boolean "refrigerator"
    t.boolean "stove"
    t.boolean "microwave"
    t.boolean "laundry"
    t.boolean "laundry_free"
    t.boolean "bike"
    t.boolean "soundproof"
    t.boolean "intercom"
    t.boolean "gated"
    t.boolean "doorman"
    t.boolean "house"
    t.boolean "apartment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "home_id"
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "home_id"
    t.integer "user_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.integer "user_id"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_chats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chat_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "notification_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
