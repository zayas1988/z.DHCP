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

ActiveRecord::Schema.define(:version => 20130411144712) do

  create_table "subnets", :force => true do |t|
    t.string   "adress"
    t.string   "mask"
    t.string   "broadcast"
    t.string   "routers"
    t.string   "nameservers"
    t.string   "domainname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subnets", ["adress"], :name => "index_subnets_on_adress", :unique => true

  create_table "tftps", :force => true do |t|
    t.string   "image"
    t.string   "group"
    t.string   "config"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tftps", ["image", "group"], :name => "index_tftps_on_image_and_group"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end