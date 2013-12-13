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

ActiveRecord::Schema.define(:version => 20131109155746) do

  create_table "code_bugs", :force => true do |t|
    t.string   "class"
    t.string   "controler"
    t.string   "action"
    t.string   "message"
    t.string   "file_name"
    t.integer  "line_number"
    t.text     "source_extract"
    t.string   "url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "consume_tags", :force => true do |t|
    t.integer  "consume_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "consumes", :force => true do |t|
    t.float    "volue"
    t.text     "msg"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "drafts", :force => true do |t|
    t.integer  "segment_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "edm_logs", :force => true do |t|
    t.integer  "edm_id"
    t.datetime "begin"
    t.float    "duration"
    t.string   "frem"
    t.string   "subject"
    t.string   "statu"
    t.string   "send_type"
    t.string   "ip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "method"
    t.string   "tu"
  end

  create_table "edms", :force => true do |t|
    t.string   "name"
    t.integer  "template_id"
    t.string   "subject"
    t.string   "from"
    t.string   "from_email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "favorities", :force => true do |t|
    t.string   "label"
    t.text     "desc"
    t.boolean  "klass"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.boolean  "is_public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "folder_name"
  end

  create_table "links", :force => true do |t|
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lives", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "info"
    t.datetime "lives_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mail_inboxes", :force => true do |t|
    t.text     "mail_orgstr"
    t.string   "mail_from"
    t.string   "mail_to"
    t.string   "mail_sender"
    t.string   "mail_subject"
    t.string   "mail_date"
    t.string   "mail_message_id"
    t.text     "mail_body"
    t.string   "mail_cc"
    t.integer  "maillist_id"
    t.integer  "inbox_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "mailers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "maillists", :force => true do |t|
    t.string   "domain"
    t.string   "email_name"
    t.string   "email_pwd"
    t.string   "email_smtp"
    t.string   "smtp_port"
    t.string   "login_name"
    t.string   "email_pop"
    t.string   "pop_port"
    t.integer  "mailer_id"
    t.boolean  "is_valid"
    t.string   "unvalid"
    t.integer  "sign_index"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_tags", :force => true do |t|
    t.integer  "member_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "isvalid"
    t.boolean  "issubscribed"
    t.text     "msg"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "member_type"
  end

  create_table "mqueues", :force => true do |t|
    t.string   "mqpath"
    t.string   "domain"
    t.integer  "index"
    t.boolean  "is_valid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mxes", :force => true do |t|
    t.string   "domain"
    t.string   "server"
    t.integer  "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "old_users_authlogic", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "orgs_mails", :force => true do |t|
    t.integer  "mailer_id"
    t.integer  "maillist_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "photo_albums", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "folder_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photo_tags", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "path"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "original_name"
  end

  create_table "replies", :force => true do |t|
    t.integer  "segment_id"
    t.integer  "reply_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "email"
  end

  create_table "reply_tags", :force => true do |t|
    t.integer  "reply_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "segment_histories", :force => true do |t|
    t.integer  "segment_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "segments", :force => true do |t|
    t.integer  "life_id"
    t.text     "content"
    t.text     "markdown"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title"
    t.string   "permlink"
    t.integer  "segment_type"
  end

  create_table "segments_tags", :force => true do |t|
    t.integer  "segment_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sites", :force => true do |t|
    t.integer  "favority_id"
    t.string   "name"
    t.string   "url"
    t.string   "desc"
    t.string   "logo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "taggroups", :force => true do |t|
    t.integer  "tag_id"
    t.string   "label"
    t.integer  "isprivate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_type"
  end

  create_table "tags", :force => true do |t|
    t.string   "label"
    t.integer  "tag_type"
    t.integer  "user_id"
    t.string   "p_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tgs_tags", :force => true do |t|
    t.integer  "taggroup_id"
    t.integer  "tag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "todo_tags", :force => true do |t|
    t.integer  "todo_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "todos", :force => true do |t|
    t.string   "todo"
    t.text     "desc"
    t.boolean  "isover"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "trackers", :force => true do |t|
    t.integer  "userid"
    t.string   "url"
    t.string   "controller"
    t.string   "action"
    t.text     "browser"
    t.string   "ip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "track_type"
  end

  create_table "user_tags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weixin_recevers", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.text     "content"
    t.string   "pic_url"
    t.string   "media_id"
    t.string   "format"
    t.string   "thumb_media_id"
    t.string   "location_x"
    t.string   "location_y"
    t.string   "scale"
    t.string   "label"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "msg_id"
    t.string   "event"
    t.string   "event_key"
    t.string   "ticket"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "precision"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
