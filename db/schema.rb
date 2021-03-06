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

ActiveRecord::Schema.define(version: 20170201234934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "tablefunc"
  enable_extension "pgcrypto"
  enable_extension "hstore"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "budget"
    t.integer  "logic_model_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["logic_model_id"], name: "index_activities_on_logic_model_id", using: :btree
  end

  create_table "analyses", force: :cascade do |t|
    t.string   "display_value",       default: "Do not display"
    t.string   "title"
    t.text     "description"
    t.integer  "data_combination_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["data_combination_id"], name: "index_analyses_on_data_combination_id", using: :btree
  end

  create_table "budget_entries", force: :cascade do |t|
    t.integer  "amount"
    t.string   "date"
    t.integer  "budget_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_entries_on_budget_id", using: :btree
  end

  create_table "budgets", force: :cascade do |t|
    t.string   "name"
    t.integer  "total"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_budgets_on_program_id", using: :btree
  end

  create_table "collection_dates", force: :cascade do |t|
    t.string   "date"
    t.integer  "performance_indicator_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["performance_indicator_id"], name: "index_collection_dates_on_performance_indicator_id", using: :btree
  end

  create_table "data_combinations", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "survey_template_id"
    t.string   "criterion_1"
    t.string   "criterion_2"
    t.string   "data_question_1_id"
    t.string   "data_question_2_id"
    t.string   "display_value"
    t.string   "data_label_1"
    t.string   "data_label_2"
    t.string   "category"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["survey_template_id"], name: "index_data_combinations_on_survey_template_id", using: :btree
  end

  create_table "data_questions", force: :cascade do |t|
    t.text     "description"
    t.string   "question_type"
    t.boolean  "multiple_answers",         default: false
    t.integer  "position"
    t.integer  "performance_indicator_id"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "survey_template_id"
    t.string   "display_value",            default: "Do not display"
    t.integer  "survey_id"
    t.index ["performance_indicator_id"], name: "index_data_questions_on_performance_indicator_id", using: :btree
    t.index ["survey_id"], name: "index_data_questions_on_survey_id", using: :btree
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "program_id"
    t.index ["program_id"], name: "index_frameworks_on_program_id", using: :btree
  end

  create_table "impacts", force: :cascade do |t|
    t.text     "description"
    t.integer  "logic_model_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["logic_model_id"], name: "index_impacts_on_logic_model_id", using: :btree
  end

  create_table "logic_model_inputs", force: :cascade do |t|
    t.text     "description"
    t.integer  "logic_model_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["logic_model_id"], name: "index_logic_model_inputs_on_logic_model_id", using: :btree
  end

  create_table "logic_models", force: :cascade do |t|
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_logic_models_on_program_id", using: :btree
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

  create_table "outcomes", force: :cascade do |t|
    t.text     "description"
    t.integer  "logic_model_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["logic_model_id"], name: "index_outcomes_on_logic_model_id", using: :btree
  end

  create_table "outputs", force: :cascade do |t|
    t.text     "description"
    t.integer  "logic_model_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["logic_model_id"], name: "index_outputs_on_logic_model_id", using: :btree
  end

  create_table "performance_indicators", force: :cascade do |t|
    t.text     "description"
    t.string   "data_source"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "chart_type"
    t.integer  "evaluative_question_id"
    t.index ["evaluative_question_id"], name: "index_performance_indicators_on_evaluative_question_id", using: :btree
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.text     "problem_description"
    t.text     "solution_description"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "organization_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["organization_id"], name: "index_programs_on_organization_id", using: :btree
  end

  create_table "survey_responses", force: :cascade do |t|
    t.text     "input_value"
    t.integer  "survey_id"
    t.integer  "data_question_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["data_question_id"], name: "index_survey_responses_on_data_question_id", using: :btree
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id", using: :btree
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

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.integer  "organization_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["organization_id"], name: "index_users_on_organization_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "activities", "logic_models"
  add_foreign_key "analyses", "data_combinations"
  add_foreign_key "budget_entries", "budgets"
  add_foreign_key "budgets", "programs"
  add_foreign_key "collection_dates", "performance_indicators"
  add_foreign_key "data_combinations", "survey_templates"
  add_foreign_key "data_questions", "performance_indicators"
  add_foreign_key "data_questions", "survey_templates"
  add_foreign_key "data_questions", "surveys"
  add_foreign_key "evaluative_questions", "frameworks"
  add_foreign_key "frameworks", "programs"
  add_foreign_key "impacts", "logic_models"
  add_foreign_key "logic_model_inputs", "logic_models"
  add_foreign_key "logic_models", "programs"
  add_foreign_key "options", "data_questions"
  add_foreign_key "outcomes", "logic_models"
  add_foreign_key "outputs", "logic_models"
  add_foreign_key "performance_indicators", "evaluative_questions"
  add_foreign_key "programs", "organizations"
  add_foreign_key "survey_responses", "data_questions"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "survey_templates", "frameworks"
  add_foreign_key "surveys", "survey_templates"
  add_foreign_key "users", "organizations"
end
