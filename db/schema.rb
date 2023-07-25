# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_21_113944) do
  create_table "admins", charset: "utf8mb3", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "isadmin", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", charset: "utf8mb3", force: :cascade do |t|
    t.string "client_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forms", charset: "utf8mb3", force: :cascade do |t|
    t.string "your_name"
    t.date "date_from"
    t.date "date_to"
    t.text "reason_for_leave"
    t.string "leaving_type"
    t.string "status", default: "pending"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_calculations", charset: "utf8mb3", force: :cascade do |t|
    t.string "staff_details"
    t.string "type_of_leave"
    t.integer "total_days"
    t.integer "used_days"
    t.integer "available_days"
    t.integer "leave_type_id"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_types", charset: "utf8mb3", force: :cascade do |t|
    t.string "leave_reason"
    t.integer "days_allowed"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", charset: "utf8mb3", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", charset: "utf8mb3", force: :cascade do |t|
    t.string "bio"
    t.string "avatar"
    t.string "about"
    t.string "location"
    t.string "bio_name"
    t.string "my_email"
    t.string "tech"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", charset: "utf8mb3", force: :cascade do |t|
    t.string "project_name"
    t.text "description"
    t.string "client_details"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", charset: "utf8mb3", force: :cascade do |t|
    t.string "staff_name"
    t.date "joining_date"
    t.string "reporting_to"
    t.string "email"
    t.string "password_digest"
    t.text "tech_stack"
    t.boolean "isStaff", default: true
    t.integer "admin_id"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", charset: "utf8mb3", force: :cascade do |t|
    t.string "task_name"
    t.string "assigned_to"
    t.string "managed_by"
    t.string "project_name"
    t.integer "project_id"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheets", charset: "utf8mb3", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.text "progress_details"
    t.string "task_detail"
    t.integer "task_id", null: false
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
