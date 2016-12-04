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

ActiveRecord::Schema.define(version: 20161203085002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_products", force: :cascade do |t|
    t.integer  "order_id",               null: false
    t.integer  "product_id",             null: false
    t.integer  "count",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_order_products_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_products_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true, using: :btree
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "user_id",                                   null: false
    t.string   "name",                         default: "", null: false
    t.string   "owner_name",                   default: "", null: false
    t.string   "owner_telephone",              default: "", null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "license_picture_file_name"
    t.string   "license_picture_content_type"
    t.integer  "license_picture_file_size"
    t.datetime "license_picture_updated_at"
    t.index ["user_id"], name: "index_stores_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "remember_created_at"
    t.string   "open_id",                              default: "",    null: false
    t.string   "raw_auth",                             default: "",    null: false
    t.string   "name",                                 default: "",    null: false
    t.string   "school",                               default: "",    null: false
    t.string   "shipping_address",                     default: "",    null: false
    t.string   "telephone",                            default: "",    null: false
    t.boolean  "info_filled",                          default: false, null: false
    t.integer  "region_id"
    t.integer  "stores_count",                         default: 0
    t.integer  "orders_count",                         default: 0
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "id_card_picture_file_name"
    t.string   "id_card_picture_content_type"
    t.integer  "id_card_picture_file_size"
    t.datetime "id_card_picture_updated_at"
    t.string   "id_card_reverse_picture_file_name"
    t.string   "id_card_reverse_picture_content_type"
    t.integer  "id_card_reverse_picture_file_size"
    t.datetime "id_card_reverse_picture_updated_at"
    t.index ["open_id"], name: "index_users_on_open_id", unique: true, using: :btree
    t.index ["region_id"], name: "index_users_on_region_id", using: :btree
  end

end
