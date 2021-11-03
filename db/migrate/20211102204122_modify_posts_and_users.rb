class ModifyPostsAndUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :content, :text, null: false
    add_column :users, :email, :text, null: false
  end
end

