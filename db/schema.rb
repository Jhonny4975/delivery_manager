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

ActiveRecord::Schema[7.0].define(version: 2022_05_31_105905) do
  create_table "budgets", force: :cascade do |t|
    t.decimal "max_size", null: false
    t.decimal "min_size", null: false
    t.decimal "max_weight", null: false
    t.decimal "min_weight", null: false
    t.decimal "price", null: false
    t.integer "transporter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transporter_id"], name: "index_budgets_on_transporter_id"
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "max_distance", null: false
    t.integer "min_distance", null: false
    t.integer "period", null: false
    t.integer "transporter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transporter_id"], name: "index_deadlines_on_transporter_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.decimal "height", null: false
    t.decimal "length", null: false
    t.decimal "width", null: false
    t.decimal "weight", null: false
    t.decimal "distance", null: false
    t.string "pickup_address", null: false
    t.string "recipient_name", null: false
    t.string "recipient_phone_number", null: false
    t.string "recipient_document", null: false
    t.string "delivery_address", null: false
    t.string "code"
    t.string "sku", null: false
    t.integer "stats", default: 0, null: false
    t.integer "transporter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id"
    t.index ["code"], name: "unique_code", unique: true
    t.index ["transporter_id"], name: "index_service_orders_on_transporter_id"
    t.index ["vehicle_id"], name: "index_service_orders_on_vehicle_id"
  end

  create_table "transporters", force: :cascade do |t|
    t.string "corporate_name", null: false
    t.string "brand_name", null: false
    t.string "domain", null: false
    t.string "registration_number", null: false
    t.string "full_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "min_price"
    t.integer "stats", default: 0
    t.index ["brand_name"], name: "unique_brand_name", unique: true
    t.index ["corporate_name"], name: "unique_corporate_name", unique: true
    t.index ["domain"], name: "unique_domain", unique: true
    t.index ["full_address"], name: "unique_full_address", unique: true
    t.index ["registration_number"], name: "unique_registration_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "branch_office_name"
    t.string "phone_number"
    t.integer "transporter_id"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_office_name"], name: "index_users_on_branch_office_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["transporter_id"], name: "index_users_on_transporter_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate", null: false
    t.string "brand_name", null: false
    t.string "model", null: false
    t.string "year"
    t.string "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["license_plate"], name: "unique_license_plate", unique: true
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "budgets", "transporters"
  add_foreign_key "deadlines", "transporters"
  add_foreign_key "service_orders", "transporters"
  add_foreign_key "service_orders", "vehicles"
  add_foreign_key "users", "transporters"
  add_foreign_key "vehicles", "users"
end
