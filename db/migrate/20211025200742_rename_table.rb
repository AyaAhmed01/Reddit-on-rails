class RenameTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_subs, :post_sub_tags
  end
end
