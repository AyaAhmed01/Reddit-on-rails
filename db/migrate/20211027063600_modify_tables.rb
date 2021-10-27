class ModifyTables < ActiveRecord::Migration[6.1]
  def change
    add_index :post_sub_tags, :post_id 
    add_index :post_sub_tags, :sub_id  
    remove_column :posts, :sub_id 
    add_index :subs, :title, unique: true 
  end
end
