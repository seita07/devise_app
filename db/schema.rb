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

ActiveRecord::Schema.define(version: 2021_06_01_053135) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "timepost_id"
    t.text "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timepost_id"], name: "index_comments_on_timepost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "method_likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "methodpost_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["methodpost_id"], name: "index_method_likes_on_methodpost_id"
    t.index ["user_id"], name: "index_method_likes_on_user_id"
  end

  create_table "methodposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "subjects"
    t.index ["user_id", "created_at"], name: "index_methodposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_methodposts_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "methodpost_id"
    t.text "text", null: false
    t.float "evaluation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["methodpost_id"], name: "index_reviews_on_methodpost_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "time_likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "timepost_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timepost_id"], name: "index_time_likes_on_timepost_id"
    t.index ["user_id"], name: "index_time_likes_on_user_id"
  end

  create_table "timeposts", force: :cascade do |t|
    t.text "content"
    t.integer "time"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "subjects"
    t.integer "minitus"
    t.string "img"
    t.integer "studytime"
    t.datetime "datetime"
    t.index ["user_id", "created_at"], name: "index_timeposts_on_user_id_and_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "gender"
    t.date "birth_date"
    t.string "prefectures"
    t.string "occupation"
    t.string "target_school"
    t.text "comment"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "timeposts"
  add_foreign_key "comments", "users"
  add_foreign_key "method_likes", "methodposts"
  add_foreign_key "method_likes", "users"
  add_foreign_key "methodposts", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "reviews", "methodposts"
  add_foreign_key "reviews", "users"
  add_foreign_key "time_likes", "timeposts"
  add_foreign_key "time_likes", "users"
end
