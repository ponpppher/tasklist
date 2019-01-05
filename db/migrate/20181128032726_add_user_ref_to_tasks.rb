# frozen_string_literal: true

class AddUserRefToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, foreign_key: true
  end
end
