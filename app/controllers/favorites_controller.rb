class FavoritesController < ApplicationController
  before_action :not_allow_destroy, only:[:destroy]

  def create
  	@favorite = current_user.favorites.build(group_id: params[:group_id], user_id: current_user.id)
  	@favorite.save
  	redirect_to groups_path
  end

  def destroy
  	@favorite = Favorite.find_by(group_id: params[:group_id], user_id: @current_user.id)
  	@favorite.destroy
  	redirect_to groups_path
  end

  def index
     @favorites = Favorite.all
  end

  private

  def not_allow_destroy
    @favorite = Favorite.find_by(group_id: params[:group_id], user_id: @current_user.id)
    if @current_user.id == @group.owner_id
      flash[:info] = "グループ作成者は脱退できません"
      redirect_to groups_path
    end 
  end
end
