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

ActiveRecord::Schema[8.0].define(version: 0) do
  create_table "cache", primary_key: "key", id: :string, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "value", size: :medium, null: false
    t.integer "expiration", null: false
  end

  create_table "cache_locks", primary_key: "key", id: :string, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "owner", null: false
    t.integer "expiration", null: false
  end

  create_table "failed_jobs", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.text "connection", null: false
    t.text "queue", null: false
    t.text "payload", size: :long, null: false
    t.text "exception", size: :long, null: false
    t.timestamp "failed_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["uuid"], name: "failed_jobs_uuid_unique", unique: true
  end

  create_table "job_batches", id: :string, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "total_jobs", null: false
    t.integer "pending_jobs", null: false
    t.integer "failed_jobs", null: false
    t.text "failed_job_ids", size: :long, null: false
    t.text "options", size: :medium
    t.integer "cancelled_at"
    t.integer "created_at", null: false
    t.integer "finished_at"
  end

  create_table "jobs", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "queue", null: false
    t.text "payload", size: :long, null: false
    t.integer "attempts", limit: 1, null: false, unsigned: true
    t.integer "reserved_at", unsigned: true
    t.integer "available_at", null: false, unsigned: true
    t.integer "created_at", null: false, unsigned: true
    t.index ["queue"], name: "jobs_queue_index"
  end

  create_table "migrations", id: { type: :integer, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "migration", null: false
    t.integer "batch", null: false
  end

  create_table "password_reset_tokens", primary_key: "email", id: :string, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "token", null: false
    t.timestamp "created_at"
  end

  create_table "sessions", id: :string, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", unsigned: true
    t.string "ip_address", limit: 45
    t.text "user_agent"
    t.text "payload", size: :long, null: false
    t.integer "last_activity", null: false
    t.index ["last_activity"], name: "sessions_last_activity_index"
    t.index ["user_id"], name: "sessions_user_id_index"
  end

  create_table "users", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.timestamp "email_verified_at"
    t.string "password", null: false
    t.string "remember_token", limit: 100
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.index ["email"], name: "users_email_unique", unique: true
  end
end
