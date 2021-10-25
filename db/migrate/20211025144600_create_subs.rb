class CreateSubs < ActiveRecord::Migration[6.1]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description
      t.integer :moderator_id, null: false
      t.index :moderator_id
      t.timestamps
    end
  end
end
