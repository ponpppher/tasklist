# frozen_string_literal: true

class AddColumnTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit_datetime, :datetime, null: false, default: ''
  end
end
