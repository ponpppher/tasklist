class AddReadToTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :read, :boolean
    add_column :tasks, :read, :boolean, default: false
  end
end
