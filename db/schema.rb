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

ActiveRecord::Schema.define(version: 20171002143949) do

  create_table "book_shelves", force: :cascade do |t|
    t.integer "book_id"
    t.integer "shelf_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "goodread_book_id"
    t.string "isbn13"
    t.string "title"
    t.string "author"
    t.string "publisher"
    t.string "image"
    t.text "description"
    t.integer "ratings_count"
    t.decimal "ratings_average"
    t.integer "year_published"
    t.string "book_shelve_name"
    t.integer "reviews_count"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.integer "book_id"
    t.integer "user_id"
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
