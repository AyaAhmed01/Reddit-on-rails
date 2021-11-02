class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.integer :sub_id, null: false 
      t.integer :user_id, null: false
      t.index :sub_id 
      t.index :user_id 
      t.index [:user_id, :sub_id], unique: true 
      t.timestamps
    end
  end
end
