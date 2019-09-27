class FavoritesController < ApplicationController
  def create
  	favorite = current_user.favorites.build(group_id: params[:group_id])
  	favorite.save
  	redirect_to groups_path
  end

  def destroy
  	favorite = Favorite.find_by(group_id: params[:group_id], user_id: current_user.id)
  	favorite.destroy
  	redirect_to groups_path
  end
end
