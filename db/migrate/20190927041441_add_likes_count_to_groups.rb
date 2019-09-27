class AddLikesCountToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :likes_count, :integer
  end
end
