# frozen_string_literal: true

class AddLabelRefToTask < ActiveRecord::Migration[5.2]
  def change
    add_reference :labels, :user, foreign_key: true
  end
end
