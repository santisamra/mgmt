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

ActiveRecord::Schema.define(:version => 20130303225659) do

  create_table "issues", :force => true do |t|
    t.string   "status",          :default => "not_started"
    t.string   "issue_type",      :default => "feature"
    t.decimal  "estimated_hours"
    t.decimal  "worked_hours",    :default => 0.0
    t.integer  "number"
    t.integer  "repository_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "issues", ["repository_id"], :name => "index_issues_on_repository_id"

  create_table "repositories", :force => true do |t|
    t.string   "organization"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "repositories", ["organization", "name"], :name => "index_repositories_on_organization_and_name"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "login"
    t.string   "token"
    t.string   "organization_avatar"
    t.string   "gravatar_id"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true

end
