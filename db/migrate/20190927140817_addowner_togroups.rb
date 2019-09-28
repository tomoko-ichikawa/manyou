class AddownerTogroups < ActiveRecord::Migration[5.2]
  def change
  	  add_column :groups, :owner, :integer
  end
end
