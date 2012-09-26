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

ActiveRecord::Schema.define(:version => 20120919065407) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "albums", ["user_id"], :name => "index_alblums_on_user_id"

  create_table "carousel_photos", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.string   "session_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uuid"
    t.integer  "promo_id"
  end

  add_index "carts", ["session_id"], :name => "index_carts_on_session_id"
  add_index "carts", ["uuid"], :name => "index_carts_on_uuid"

  create_table "girl_friday_messages", :force => true do |t|
    t.string "queue_name"
    t.text   "msg"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "photo_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "size"
    t.integer  "order_id"
    t.text     "download_url"
  end

  add_index "line_items", ["cart_id"], :name => "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], :name => "index_line_items_on_order_id"
  add_index "line_items", ["photo_id"], :name => "index_line_items_on_photo_id"

  create_table "orders", :force => true do |t|
    t.string   "uuid"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "buyer_email"
    t.integer  "line_items_count"
    t.decimal  "total",            :precision => 8, :scale => 2
    t.string   "payment_status"
    t.integer  "promo_id"
    t.decimal  "promo_discount",   :precision => 8, :scale => 2
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"
  add_index "orders", ["uuid"], :name => "index_orders_on_uuid"

  create_table "paypal_receipts", :force => true do |t|
    t.text     "params"
    t.string   "uuid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["album_id"], :name => "index_photos_on_alblum_id"

  create_table "promos", :force => true do |t|
    t.decimal  "fixed_discount",      :precision => 8, :scale => 2
    t.integer  "percentage_discount"
    t.string   "code"
    t.date     "expires_on"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "promos", ["code"], :name => "index_promos_on_code"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
