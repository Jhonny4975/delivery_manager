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

ActiveRecord::Schema[7.0].define(version: 2022_05_19_205305) do
  create_table "transporters", force: :cascade do |t|
    t.string "corporate_name", null: false
    t.string "brand_name", null: false
    t.string "domain", null: false
    t.string "registration_number", null: false
    t.string "full_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_name"], name: "unique_brand_name", unique: true
    t.index ["corporate_name"], name: "unique_corporate_name", unique: true
    t.index ["domain"], name: "unique_domain", unique: true
    t.index ["full_address"], name: "unique_full_address", unique: true
    t.index ["registration_number"], name: "unique_registration_number", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate", null: false
    t.string "brand_name", null: false
    t.string "model", null: false
    t.string "year"
    t.string "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["license_plate"], name: "unique_license_plate", unique: true
  end

end
