class InitSchema < ActiveRecord::Migration
  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
    create_table "labelings" do |t|
      t.bigint "task_id"
      t.bigint "label_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["label_id"], name: "index_labelings_on_label_id"
      t.index ["task_id"], name: "index_labelings_on_task_id"
    end
    create_table "labels" do |t|
      t.string "name"
      t.bigint "user_id"
      t.index ["user_id"], name: "index_labels_on_user_id"
#      add_reference :labels, :user, foreign_key: true
    end
    create_table "tasks" do |t|
      t.string "title", null: false
      t.string "content", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "limit_datetime", null: false
      t.integer "priority", limit: 2, default: 1, null: false
      t.bigint "user_id"
      t.integer "status", limit: 2, default: 0, null: false
      t.index ["content"], name: "index_tasks_on_content"
      t.index ["priority"], name: "index_tasks_on_priority"
      t.index ["status"], name: "index_tasks_on_status"
      t.index ["title"], name: "index_tasks_on_title"
      t.index ["user_id"], name: "index_tasks_on_user_id"
    end
    create_table "users" do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "admin", default: false, null: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
    add_foreign_key "labelings", "labels"
    add_foreign_key "labelings", "tasks"
    add_foreign_key "tasks", "users"
    add_foreign_key "labels", "users"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
