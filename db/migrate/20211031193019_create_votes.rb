class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :value, null: false 
      t.references :votable, polymorphic: true
      t.timestamps
    end
  end
end
