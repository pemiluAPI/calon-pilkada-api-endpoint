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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151011235045) do

  create_table "candidates", force: true do |t|
    t.integer  "province_id"
    t.integer  "region_id"
    t.string   "id_participant"
    t.string   "endorsement_type"
    t.text     "endorsement"
    t.string   "vote_type"
    t.string   "acceptance_status"
    t.string   "document_completeness"
    t.string   "research_result"
    t.string   "acceptance_document_repair"
    t.string   "amount_support"
    t.string   "amount_support_repair"
    t.string   "amount_support_determination"
    t.string   "eligibility_support"
    t.string   "eligibility_support_repair"
    t.string   "pertahana"
    t.string   "dynasty"
    t.string   "amount_women"
    t.string   "incumbent"
    t.string   "resource"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidates", ["endorsement_type"], name: "index_candidates_on_endorsement_type", using: :btree
  add_index "candidates", ["province_id"], name: "index_candidates_on_province_id", using: :btree
  add_index "candidates", ["region_id"], name: "index_candidates_on_region_id", using: :btree
  add_index "candidates", ["vote_type"], name: "index_candidates_on_vote_type", using: :btree

  create_table "participants", force: true do |t|
    t.integer  "candidate_id"
    t.string   "kind"
    t.string   "name"
    t.string   "gender"
    t.string   "pob"
    t.string   "dob"
    t.text     "address"
    t.string   "work"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["candidate_id"], name: "index_participants_on_candidate_id", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.integer  "province_id"
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["province_id"], name: "index_regions_on_province_id", using: :btree

  create_table "vision_missions", force: true do |t|
    t.integer  "candidate_id"
    t.text     "vision"
    t.text     "mission"
    t.text     "resource"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
