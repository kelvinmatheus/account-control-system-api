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

ActiveRecord::Schema.define(version: 20180205022309) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 70, null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "status", limit: 1, default: 2, null: false
    t.string "person_type"
    t.bigint "person_id"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_accounts_on_ancestry"
    t.index ["name"], name: "index_name_unique", unique: true
    t.index ["person_type", "person_id"], name: "index_accounts_on_person_type_and_person_id"
  end

  create_table "juridical_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cnpj", limit: 14, null: false
    t.string "company_name", limit: 70, null: false
    t.string "fantasy_name", limit: 70, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnpj"], name: "index_cnpj_unique", unique: true
  end

  create_table "legal_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cpf", limit: 11, null: false
    t.string "name", limit: 70, null: false
    t.date "birthdate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_cpf_unique", unique: true
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "transactional_code", null: false
    t.integer "type", limit: 1, null: false
    t.decimal "value", precision: 10, scale: 2, null: false
    t.bigint "origin_account_id", null: false
    t.decimal "origin_account_value_before_transaction", precision: 10, scale: 2, null: false
    t.bigint "destination_account_id"
    t.decimal "destination_account_value_before_transaction", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_account_id"], name: "index_transactions_on_destination_account_id"
    t.index ["origin_account_id"], name: "index_transactions_on_origin_account_id"
    t.index ["transactional_code"], name: "index_transactional_code_unique", unique: true
  end

  add_foreign_key "transactions", "accounts", column: "destination_account_id"
  add_foreign_key "transactions", "accounts", column: "origin_account_id"
end
