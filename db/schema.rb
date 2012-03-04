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

ActiveRecord::Schema.define(:version => 20120304000817) do

  create_table "flyers", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_chain_id"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.text     "description"
    t.float    "regular_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_chain_id"
    t.string   "category"
    t.string   "quantity"
  end

  create_table "sale_types", :force => true do |t|
    t.string   "name"
    t.float    "percent_off"
    t.float    "dollar_off"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.integer  "item_id"
    t.integer  "sale_type_id"
    t.integer  "flyer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_chains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "description"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_chain_id"
  end

end
