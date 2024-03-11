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

ActiveRecord::Schema[7.1].define(version: 2024_03_11_084040) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "name"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_courses_on_section_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "grades", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.decimal "grade"
    t.date "date"
    t.string "exam_name"
    t.text "comment"
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_grades_on_course_id"
    t.index ["student_id"], name: "index_grades_on_student_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.bigint "parent_id"
    t.string "first_name"
    t.string "last_name"
    t.string "type"
    t.bigint "section_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["section_id"], name: "index_users_on_section_id"
  end

  add_foreign_key "courses", "sections"
  add_foreign_key "courses", "users", column: "teacher_id"
  add_foreign_key "grades", "courses"
  add_foreign_key "grades", "users", column: "student_id"
  add_foreign_key "users", "users", column: "parent_id"
end
