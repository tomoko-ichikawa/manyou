class AddownerNameTofavorites < ActiveRecord::Migration[5.2]
  def change
  	  add_column :favorites, :owner_name, :boolean, default: false, null: false
  end
end
