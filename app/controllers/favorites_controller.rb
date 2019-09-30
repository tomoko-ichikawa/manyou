class FavoritesController < ApplicationController
  def create
  	if @favorite = current_user.favorites.build(group_id: params[:group_id], user_id: current_user.id)
  	   @favorite.save
  	   redirect_to groups_path
    elsif owner_id = true
       @favorite.save
       redirect_to groups_path
    end
  end

  def destroy
  	@favorite = Favorite.find_by(group_id: params[:group_id], user_id: @current_user.id)
  	@favorite.destroy
  	redirect_to groups_path
  end

  def index
     @favorites = Favorite.all
  end
end
