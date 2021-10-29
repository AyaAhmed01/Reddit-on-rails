class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.integer :post_id, null: false
      t.integer :author_id, null: false
      t.index :post_id
      t.index :author_id
      t.timestamps
    end
  end
end
