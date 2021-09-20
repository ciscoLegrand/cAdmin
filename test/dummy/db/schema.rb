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

ActiveRecord::Schema.define(version: 2021_09_20_190052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cadmin_articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.date "published_at", default: "2021-09-20", null: false
    t.date "unpublished_at"
    t.string "metatitle"
    t.string "metadata"
    t.text "image_data"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "cadmin_users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "email", default: "", null: false
    t.integer "phone", null: false
    t.integer "postal_code"
    t.string "province"
    t.string "address"
    t.date "birthdate"
    t.text "avatar_data"
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
    t.index ["confirmation_token"], name: "index_cadmin_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_cadmin_users_on_email", unique: true
    t.index ["phone"], name: "index_cadmin_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_cadmin_users_on_reset_password_token", unique: true
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

  add_foreign_key "cadmin_articles", "cadmin_users", column: "user_id"
  add_foreign_key "cadmin_comments", "cadmin_articles", column: "article_id"
  add_foreign_key "cadmin_comments", "cadmin_users", column: "user_id"
end
