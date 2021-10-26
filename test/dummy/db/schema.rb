# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_25_190969) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cadmin_article_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.date "published_at", default: "2021-10-25", null: false
    t.date "unpublished_at"
    t.string "metatitle"
    t.string "metadata"
    t.text "image_data"
    t.bigint "user_id", null: false
    t.bigint "article_category_id", null: false
    t.text "tag_ids"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_category_id"], name: "index_cadmin_articles_on_article_category_id"
    t.index ["user_id"], name: "index_cadmin_articles_on_user_id"
  end

  create_table "cadmin_comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_cadmin_comments_on_article_id"
    t.index ["user_id"], name: "index_cadmin_comments_on_user_id"
  end

  create_table "cadmin_conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_discounts", force: :cascade do |t|
    t.string "name"
    t.string "type_discount"
    t.text "description"
    t.float "percentage"
    t.float "amount"
    t.date "start_date"
    t.date "end_date"
    t.text "observations"
    t.bigint "event_id"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_cadmin_discounts_on_event_id"
    t.index ["service_id"], name: "index_cadmin_discounts_on_service_id"
  end

  create_table "cadmin_events", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "employee_id"
    t.string "title"
    t.string "type_name", default: "wedding", null: false
    t.string "number", null: false
    t.date "date", null: false
    t.integer "guests"
    t.integer "start_time"
    t.integer "extra_hours", default: 0, null: false
    t.text "service_ids"
    t.integer "place_id"
    t.float "deposit", default: 0.0, null: false
    t.float "total_amount", default: 0.0, null: false
    t.boolean "charged", default: false, null: false
    t.text "observations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_locations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.integer "postal_code"
    t.string "province"
    t.text "coords"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_main_services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_messages", force: :cascade do |t|
    t.text "body"
    t.boolean "viewed", default: false
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_cadmin_messages_on_conversation_id"
    t.index ["user_id"], name: "index_cadmin_messages_on_user_id"
  end

  create_table "cadmin_services", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.float "hour_price", default: 0.0, null: false
    t.text "short_dscription"
    t.text "description"
    t.text "features"
    t.integer "stock"
    t.string "metatitle"
    t.text "metadescription"
    t.text "image_data"
    t.bigint "main_service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["main_service_id"], name: "index_cadmin_services_on_main_service_id"
  end

  create_table "cadmin_taggings", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_cadmin_taggings_on_article_id"
    t.index ["tag_id"], name: "index_cadmin_taggings_on_tag_id"
  end

  create_table "cadmin_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "phone", null: false
    t.integer "postal_code"
    t.string "city"
    t.string "province"
    t.text "address"
    t.text "shipping_address"
    t.text "billing_address"
    t.date "birthdate"
    t.text "avatar_data"
    t.datetime "deleted_at"
    t.string "role", default: "user", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["confirmation_token"], name: "index_cadmin_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_cadmin_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_cadmin_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_cadmin_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_cadmin_users_on_invited_by"
    t.index ["phone"], name: "index_cadmin_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_cadmin_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_cadmin_users_on_username", unique: true
  end

  create_table "cadmin_web_modules", force: :cascade do |t|
    t.boolean "blog"
    t.boolean "gallery"
    t.boolean "mailbox"
    t.boolean "opinions"
    t.boolean "newsletter"
    t.boolean "reservation"
    t.boolean "social_media"
    t.boolean "invitable"
    t.boolean "paypal"
    t.boolean "stripe"
    t.boolean "adyen"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "cadmin_articles", "cadmin_article_categories", column: "article_category_id"
  add_foreign_key "cadmin_articles", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_comments", "cadmin_articles", column: "article_id"
  add_foreign_key "cadmin_comments", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_discounts", "cadmin_events", column: "event_id"
  add_foreign_key "cadmin_discounts", "cadmin_services", column: "service_id"
  add_foreign_key "cadmin_messages", "cadmin_conversations", column: "conversation_id"
  add_foreign_key "cadmin_messages", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_services", "cadmin_main_services", column: "main_service_id"
  add_foreign_key "cadmin_taggings", "cadmin_articles", column: "article_id"
  add_foreign_key "cadmin_taggings", "cadmin_tags", column: "tag_id"
end
