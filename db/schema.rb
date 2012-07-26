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

ActiveRecord::Schema.define(:version => 20120719150756) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.string   "action"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "encrypted_password",     :limit => 128,                :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "super_user"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "editor"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "applications", :force => true do |t|
    t.integer  "user_id"
    t.text     "primary_commitment"
    t.text     "collab_org"
    t.text     "description"
    t.string   "commitmentcat"
    t.text     "year1"
    t.text     "year2"
    t.text     "year3"
    t.text     "year4"
    t.string   "org_commitment_type"
    t.text     "further_info"
    t.text     "add_info"
    t.string   "avatar"
    t.boolean  "is_consent"
    t.integer  "secondary_id"
    t.integer  "vetting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_submitted",            :default => false
    t.text     "supp_commitment"
    t.text     "supp_add_commitment"
    t.string   "supp_add_commitemnt_cat"
    t.text     "supp_year1"
    t.text     "supp_year3"
    t.text     "supp_year5"
    t.string   "supp_commitment_type"
    t.string   "supp_launch"
    t.text     "supp_further_info"
    t.text     "supp_add_info"
    t.text     "supp_year2"
    t.text     "year5"
    t.text     "supp_year4"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "contacted_organizations", :force => true do |t|
    t.string   "emailid"
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reason"
    t.string   "phonenumber"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "title"
    t.string   "organization"
  end

  create_table "contents", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "is_active"
    t.string   "lede"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "section"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "donor_subjects", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "ident",      :null => false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nominations", :force => true do |t|
    t.integer  "nominator_id"
    t.integer  "nominee_id"
    t.text     "reason"
    t.text     "message"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opportunities", :force => true do |t|
    t.integer  "partner_id"
    t.string   "program_name"
    t.string   "location"
    t.string   "due_date"
    t.text     "details"
    t.string   "link"
    t.text     "additional"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "partner_name"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip"
    t.integer  "orgtype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "www"
    t.string   "avatar"
    t.string   "other"
    t.string   "partner_status"
    t.text     "commitment"
    t.text     "additional_commitment"
    t.integer  "primary_contact_id"
    t.integer  "secondary_contact_id"
    t.string   "commitment_category"
    t.string   "additional_commitment_category"
    t.date     "joined_at"
    t.string   "primary_contact_email"
    t.string   "secondary_contact_email"
    t.boolean  "is_approved"
    t.boolean  "show_contact",                   :default => true
  end

  create_table "orgtypes", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secondaries", :force => true do |t|
    t.integer  "application_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string "name"
    t.string "abbreviation"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.integer  "organization_id"
    t.boolean  "is_nominator"
    t.boolean  "is_primary_nominator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.boolean  "is_approved"
    t.string   "role",                            :default => "regular_user"
    t.boolean  "show_contact",                    :default => false
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "vettings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "application_id"
    t.string   "status"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
