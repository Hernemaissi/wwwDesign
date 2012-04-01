# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120321232629) do

  create_table "ads", :force => true do |t|
    t.string   "description"
    t.string   "image_url"
    t.string   "price"
    t.boolean  "available",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.string   "color"
    t.string   "condition"
    t.string   "size"
    t.string   "material"
    t.integer  "category_id"
  end

  add_index "ads", ["category_id"], :name => "index_ads_on_category_id"
  add_index "ads", ["user_id", "created_at"], :name => "index_ads_on_user_id_and_created_at"

  create_table "ads_parts", :id => false, :force => true do |t|
    t.integer "ad_id"
    t.integer "part_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "ad_id"
  end

  add_index "categories", ["ad_id"], :name => "index_categories_on_ad_id"

  create_table "categories_parts", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "part_id"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "ad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
  end

  add_index "requests", ["ad_id"], :name => "index_requests_on_ad_id"
  add_index "requests", ["sender_id", "ad_id"], :name => "index_requests_on_sender_id_and_ad_id", :unique => true
  add_index "requests", ["sender_id"], :name => "index_requests_on_sender_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "salt"
    t.boolean  "admin",                  :default => false
    t.integer  "notifications",          :default => 0
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
