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

ActiveRecord::Schema.define(:version => 20120127182401) do

  create_table "gov_contracts", :force => true do |t|
    t.string   "award_type"
    t.string   "contract_pricing"
    t.string   "contracting_agent"
    t.date     "date_signed"
    t.string   "reason_for_modification"
    t.string   "contract_description"
    t.decimal  "dollars_obligation",         :precision => 8, :scale => 2
    t.string   "extent_completed"
    t.string   "agency_id"
    t.string   "funding_agency"
    t.string   "major_agency"
    t.string   "parent_recipient"
    t.string   "product_or_service_code"
    t.string   "program_source_description"
    t.string   "recipient_city"
    t.string   "recipient_name"
    t.string   "recipient_zip"
    t.string   "type_of_transaction"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

end
