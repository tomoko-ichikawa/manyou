class Admin::GroupsController < ApplicationController

  GROUP_DISPLAY_PER_PAGE = 10

  def index
    @groups = Group.all.order(:id).page(params[:page]).per(GROUP_DISPLAY_PER_PAGE)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to admin_group_path(@group), notice: "グループを作成しました"
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_group_path(@group), notice: "グループを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_url, notice: "グループを作成しました"
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
