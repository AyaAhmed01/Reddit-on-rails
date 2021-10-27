class CreatePostSubs < ActiveRecord::Migration[6.1]
  def change
    create_table :post_subs do |t|
      t.integer :post_id, null: false 
      t.integer :sub_id, null: false
      t.index [:post_id, :sub_id], unique: true 
      t.timestamps
    end
  end
end
