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

  create_table "mailboxer_conversation_opt_outs", id: :serial, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :serial, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_notifications", id: :serial, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "global", default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notifications_notified_object"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :serial, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delivered", default: false
    t.string "delivery_method"
    t.string "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
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
    t.integer "gallery_id"
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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "notification_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
