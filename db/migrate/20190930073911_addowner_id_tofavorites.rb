class AddownerIdTofavorites < ActiveRecord::Migration[5.2]
  def change
  	  add_column :favorites, :owner_id, :boolean, default: false, null: false
  end
end
