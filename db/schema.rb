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

ActiveRecord::Schema.define(version: 2020_07_04_072103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.text "description"
    t.text "reference"
    t.text "memo"
    t.integer "recommend"
    t.integer "score"
    t.text "tips"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "golf_course_name"
    t.string "address"
    t.integer "latitude"
    t.integer "longitude"
    t.integer "golf_course_id"
    t.string "golf_course_image"
    t.index ["user_id", "created_at"], name: "index_courses_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "course_id"], name: "index_favorites_on_user_id_and_course_id", unique: true
  end

  create_table "lists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "from_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "course_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_logs_on_course_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "variety"
    t.text "content"
    t.integer "from_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "introduction"
    t.string "sex"
    t.integer "best_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "notification", default: false
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "courses", "users"
end
