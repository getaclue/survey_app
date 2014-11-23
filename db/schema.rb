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

ActiveRecord::Schema.define(version: 20141123202058) do

  create_table "survey_items", force: true do |t|
    t.text     "content"
    t.integer  "survey_id"
    t.integer  "question_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "question",       default: false
    t.integer  "answer_counter"
    t.boolean  "active",         default: false
  end

  add_index "survey_items", ["question"], name: "index_survey_items_on_question"
  add_index "survey_items", ["question_id"], name: "index_survey_items_on_question_id"
  add_index "survey_items", ["survey_id"], name: "index_survey_items_on_survey_id"

  create_table "surveys", force: true do |t|
    t.text     "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "surveys", ["user_id", "created_at"], name: "index_surveys_on_user_id_and_created_at"
  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "sex"
    t.integer  "age"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vote_items", force: true do |t|
    t.boolean  "active",       default: false
    t.integer  "answer_count"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "vote_items", ["answer_id"], name: "index_vote_items_on_answer_id"
  add_index "vote_items", ["question_id"], name: "index_vote_items_on_question_id"

end
