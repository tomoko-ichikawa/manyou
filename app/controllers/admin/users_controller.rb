class Admin::UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit,:update,:destroy]
  before_action :destroy_myself, only: [:destroy]

  def index
    if current_user.admin?
      @users=User.all.includes(:tasks)
      @users= @users.page(params[:page]).per(10)
    else
      redirect_to tasks_path,
                  notice: "管理者権限がありません"
    end
  end

  def show
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを登録しました！"
    else
      render 'admin/users/new'
    end
  end

  def edit
  end

  def update
    @user.update!(user_params)
    redirect_to admin_users_path, notice: "ユーザー情報を更新しました！"
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url,
    notice: "ユーザー「#{@user.user_name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:user_name,:email,:admin,:password,:password_confirmation)
  end

  def set_user
    @user=User.find(params[:id])
  end

  def destroy_myself
    if @user == current_user
      redirect_to admin_users_url,
                  notice: "自分自身を削除することは出来ません。"
    end
  end
end
