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

ActiveRecord::Schema[8.0].define(version: 2025_05_09_030843) do
  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.json "meta_data"
    t.json "options"
    t.string "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "correct_option"
  end

  create_table "scrapper_dbs", force: :cascade do |t|
    t.string "url"
    t.json "meta_data"
    t.string "source_provider"
    t.string "sub_type"
    t.json "response"
    t.string "parser_info"
    t.json "filtered_data"
    t.json "extra_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "clean_response"
    t.json "clean_response_filter"
  end
end
