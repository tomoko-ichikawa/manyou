class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :group
	validates :user_id, presence: true
  	validates :group_id, presence: true

  	def not_allow_destroy
	  @favorite = Favorite.find_by(group_id: params[:group_id], user_id: @current_user.id)
	  if @favorite.owner_id == true
	    flash[:info] = "グループ作成者は脱退できません"
	    redirect_to groups_path
	  end 
	end
end