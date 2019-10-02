class GroupsController < ApplicationController
	  GROUP_DISPLAY_PER_PAGE = 10
    before_action :ensure_owner, only:[:edit, :update, :destroy]
    before_action :favorite_user, only:[:show]

  def index
    @groups = Group.all.order(:id).page(params[:page]).per(GROUP_DISPLAY_PER_PAGE)
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find_by(id: @group.owner_id)
    @favorite_users = @group.favorite_users
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_name: group_params[:group_name], owner_id: current_user.id)
    if @group.save
      @favorite = current_user.favorites.build(group_id: @group.id, user_id: current_user.id)
      @favorite.save
      redirect_to group_path(@group),  notice: "グループを作成しました"
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group),  notice: "グループを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, notice: "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:group_name)
  end

  def ensure_owner
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id
      flash[:info] = "権限がありません"
      redirect_to groups_path
    end
  end

  def favorite_user
    @group = Group.find(params[:id])
    unless current_user.id == @group.favorites.where(user_id: current_user.id).pluck(:user_id)[0]
      flash[:info] = "所属していないグループです。"
      redirect_to groups_path
    end
  end
end
