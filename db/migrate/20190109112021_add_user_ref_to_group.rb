class AddUserRefToGroup < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :onwer_id, :integer
    add_column :groups, :owner_id, :integer, null: false
    add_index :groups, :owner_id
  end
end
