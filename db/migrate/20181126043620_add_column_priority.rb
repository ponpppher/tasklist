# frozen_string_literal: true

class AddColumnPriority < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer, null: false, default: 1, limit: 1
    add_index :tasks, :priority
  end
end
