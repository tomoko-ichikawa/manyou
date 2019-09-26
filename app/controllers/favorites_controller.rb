class FavoritesController < ApplicationController
  def create
  	@group = Group.find(params[:group_id])
  	@group.admission(current_user)
  end

  def destroy
  	@group = Favorite.find(params[:id]).group
  	@group.withdrawal(current_user)
  end
end
