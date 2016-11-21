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

ActiveRecord::Schema.define(version: 20161120001107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "tablefunc"

  create_table "data_questions", force: :cascade do |t|
    t.text     "description"
    t.string   "question_type"
    t.integer  "performance_indicator_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "survey_template_id"
    t.index ["performance_indicator_id"], name: "index_data_questions_on_performance_indicator_id", using: :btree
    t.index ["survey_template_id"], name: "index_data_questions_on_survey_template_id", using: :btree
  end

  create_table "evaluative_questions", force: :cascade do |t|
    t.string   "category"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "framework_id"
    t.index ["framework_id"], name: "index_evaluative_questions_on_framework_id", using: :btree
  end

  create_table "frameworks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.index ["organization_id"], name: "index_frameworks_on_organization_id", using: :btree
  end

  create_table "options", force: :cascade do |t|
    t.text     "description"
    t.integer  "data_question_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["data_question_id"], name: "index_options_on_data_question_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performance_indicators", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "chart_type"
    t.integer  "evaluative_question_id"
    t.index ["evaluative_question_id"], name: "index_performance_indicators_on_evaluative_question_id", using: :btree
  end

  create_table "survey_questions", force: :cascade do |t|
    t.text     "description"
    t.string   "question_type"
    t.integer  "survey_id"
    t.integer  "data_question_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["data_question_id"], name: "index_survey_questions_on_data_question_id", using: :btree
    t.index ["survey_id"], name: "index_survey_questions_on_survey_id", using: :btree
  end

  create_table "survey_responses", force: :cascade do |t|
    t.text     "input_value"
    t.integer  "survey_question_id"
    t.integer  "data_question_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["data_question_id"], name: "index_survey_responses_on_data_question_id", using: :btree
    t.index ["survey_question_id"], name: "index_survey_responses_on_survey_question_id", using: :btree
  end

  create_table "survey_templates", force: :cascade do |t|
    t.string   "name"
    t.integer  "framework_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["framework_id"], name: "index_survey_templates_on_framework_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "survey_template_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["survey_template_id"], name: "index_surveys_on_survey_template_id", using: :btree
  end

  add_foreign_key "data_questions", "performance_indicators"
  add_foreign_key "data_questions", "survey_templates"
  add_foreign_key "evaluative_questions", "frameworks"
  add_foreign_key "frameworks", "organizations"
  add_foreign_key "options", "data_questions"
  add_foreign_key "performance_indicators", "evaluative_questions"
  add_foreign_key "survey_questions", "data_questions"
  add_foreign_key "survey_questions", "surveys"
  add_foreign_key "survey_responses", "data_questions"
  add_foreign_key "survey_responses", "survey_questions"
  add_foreign_key "survey_templates", "frameworks"
  add_foreign_key "surveys", "survey_templates"
end
