class GroupsController < ApplicationController
	  GROUP_DISPLAY_PER_PAGE = 10
    before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
    @groups = Group.all.order(:id).page(params[:page]).per(GROUP_DISPLAY_PER_PAGE)
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find_by(id: @group.user_id)
    @favorite_users = @group.favorite_users
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_name: group_params[:group_name], user_id: @current_user.id)  
    if @group.save
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

  def ensure_correct_user
    @group = Group.find(params[:id])
    if @group.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/groups/index")
    end
  end

  private

  def group_params
    params.require(:group).permit(:group_name)
  end
end
