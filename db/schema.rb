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

ActiveRecord::Schema.define(version: 20171010094619) do

  create_table "book_shelves", force: :cascade do |t|
    t.integer "book_id"
    t.integer "shelf_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "goodreads_id"
    t.string "title"
    t.string "author"
    t.string "image_url"
    t.integer "year_published"
    t.float "ratings_average"
    t.integer "ratings_count"
    t.integer "reviews_count"
    t.string "book_shelf_name"
    t.text "description"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.integer "book_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shelves", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "image"
  end

end
