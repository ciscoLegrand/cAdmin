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

ActiveRecord::Schema.define(version: 2022_01_03_182420) do

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
    t.date "published_at", default: "2022-01-19", null: false
    t.date "unpublished_at"
    t.string "metatitle"
    t.string "metadata"
    t.text "image_data"
    t.bigint "user_id", null: false
    t.bigint "article_category_id", null: false
    t.text "tag_ids"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_category_id"], name: "index_cadmin_articles_on_article_category_id"
    t.index ["slug"], name: "index_cadmin_articles_on_slug", unique: true
    t.index ["user_id"], name: "index_cadmin_articles_on_user_id"
  end

  create_table "cadmin_cart_items", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "cart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cadmin_cart_items_on_cart_id"
    t.index ["service_id"], name: "index_cadmin_cart_items_on_service_id"
  end

  create_table "cadmin_carts", force: :cascade do |t|
    t.string "ip"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_cadmin_discounts_on_slug", unique: true
  end

  create_table "cadmin_email_base_templates", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.integer "kind", null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_cadmin_email_base_templates_on_slug", unique: true
  end

  create_table "cadmin_email_custom_templates", force: :cascade do |t|
    t.text "content"
    t.bigint "email_base_template_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_base_template_id"], name: "index_cadmin_email_custom_templates_on_email_base_template_id"
  end

  create_table "cadmin_event_services", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "service_id", null: false
    t.bigint "discount_id", default: 1, null: false
    t.integer "start_time"
    t.integer "overtime", default: 0, null: false
    t.float "total_amount", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discount_id"], name: "index_cadmin_event_services_on_discount_id"
    t.index ["event_id"], name: "index_cadmin_event_services_on_event_id"
    t.index ["service_id"], name: "index_cadmin_event_services_on_service_id"
  end

  create_table "cadmin_event_types", force: :cascade do |t|
    t.string "name"
    t.float "salary", default: 0.0, null: false
    t.float "overtime_price", default: 0.0, null: false
    t.float "assemble", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cadmin_events", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "employee_id"
    t.integer "cart_id"
    t.string "status", default: "pending", null: false
    t.string "title"
    t.string "type_name", default: "boda", null: false
    t.string "number", null: false
    t.date "date", null: false
    t.integer "guests"
    t.integer "place_id"
    t.float "deposit", default: 0.0, null: false
    t.float "total_amount", default: 0.0, null: false
    t.boolean "charged", default: false, null: false
    t.boolean "employee_paid", default: false, null: false
    t.text "observations"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_cadmin_events_on_slug", unique: true
  end

  create_table "cadmin_interview_options", force: :cascade do |t|
    t.string "gift"
    t.string "song"
    t.bigint "interview_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interview_id"], name: "index_cadmin_interview_options_on_interview_id"
  end

  create_table "cadmin_interviews", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.integer "employee_id"
    t.string "ceremony_music"
    t.string "appetizer_music"
    t.string "banquet_music"
    t.string "ceremony_time"
    t.string "entry"
    t.string "bridal_dance"
    t.boolean "garter"
    t.string "garter_music"
    t.boolean "figures"
    t.string "figures_music"
    t.text "gift_information"
    t.text "observations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_cadmin_interviews_on_event_id"
  end

  create_table "cadmin_locations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.integer "postal_code"
    t.string "province"
    t.text "coords"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_cadmin_locations_on_slug", unique: true
  end

  create_table "cadmin_main_services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "position"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_cadmin_main_services_on_slug", unique: true
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
    t.float "price", default: 0.0, null: false
    t.float "vat", default: 21.0, null: false
    t.float "price_no_vat", default: 0.0, null: false
    t.float "hour_price", default: 0.0, null: false
    t.text "short_dscription"
    t.text "description"
    t.text "features"
    t.integer "stock"
    t.string "metatitle"
    t.text "metadescription"
    t.text "image_data"
    t.bigint "main_service_id", null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["main_service_id"], name: "index_cadmin_services_on_main_service_id"
    t.index ["slug"], name: "index_cadmin_services_on_slug", unique: true
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

  create_table "cadmin_tracks", force: :cascade do |t|
    t.string "name"
    t.string "artist"
    t.string "image"
    t.string "preview"
    t.string "spotify_id"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_cadmin_tracks_on_slug", unique: true
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
    t.string "slug"
    t.integer "customer_id"
    t.integer "subscription_id"
    t.integer "price_id"
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
    t.index ["slug"], name: "index_cadmin_users_on_slug", unique: true
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
    t.boolean "multisafe"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  add_foreign_key "cadmin_articles", "cadmin_article_categories", column: "article_category_id"
  add_foreign_key "cadmin_articles", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_cart_items", "cadmin_carts", column: "cart_id"
  add_foreign_key "cadmin_cart_items", "cadmin_services", column: "service_id"
  add_foreign_key "cadmin_comments", "cadmin_articles", column: "article_id"
  add_foreign_key "cadmin_comments", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_email_custom_templates", "cadmin_email_base_templates", column: "email_base_template_id"
  add_foreign_key "cadmin_event_services", "cadmin_discounts", column: "discount_id"
  add_foreign_key "cadmin_event_services", "cadmin_events", column: "event_id"
  add_foreign_key "cadmin_event_services", "cadmin_services", column: "service_id"
  add_foreign_key "cadmin_interview_options", "cadmin_interviews", column: "interview_id"
  add_foreign_key "cadmin_interviews", "cadmin_events", column: "event_id"
  add_foreign_key "cadmin_messages", "cadmin_conversations", column: "conversation_id"
  add_foreign_key "cadmin_messages", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_services", "cadmin_main_services", column: "main_service_id"
  add_foreign_key "cadmin_taggings", "cadmin_articles", column: "article_id"
  add_foreign_key "cadmin_taggings", "cadmin_tags", column: "tag_id"
end
