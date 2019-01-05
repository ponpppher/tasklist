# frozen_string_literal: true

class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :status, :string, default: ''

    add_column :tasks, :status, :integer, null: false, default: 0, limit: 1
    add_index :tasks, :status
  end
end
