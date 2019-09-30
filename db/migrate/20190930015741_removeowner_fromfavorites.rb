class RemoveownerFromfavorites < ActiveRecord::Migration[5.2]
  def change
  	remove_column :favorites, :owner, :string
  end
end
