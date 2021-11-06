class ModifyUserEmail < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :email, :text, null: false, unique: true 
    add_index :users, :activation_token, unique: true 
  end
end
