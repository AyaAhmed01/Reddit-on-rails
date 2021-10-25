class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.integer :sub_id, null: false
      t.integer :author_id, null: false
      t.string :url
      t.text :content 
      t.index :sub_id
      t.index :author_id
      t.timestamps
    end
  end
end
