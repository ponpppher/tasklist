# frozen_string_literal: true

class AddColumnStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string, default: ''
    add_index :tasks, :title
    add_index :tasks, :content
  end
end
