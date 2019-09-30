class AddownerTofavorites < ActiveRecord::Migration[5.2]
  def change
  	add_column :favorites, :owner, :string
  end
end
