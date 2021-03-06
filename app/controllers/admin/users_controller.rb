class Admin::UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit,:update,:destroy]
  before_action :destroy_myself, only: [:destroy]

  def index
    if current_user.admin?
      @users = User.all.includes(:tasks)
      @users = @users.page(params[:page]).per(10)
    else
      # render file: 'public/404', status: 404, formats: [:html]
      # ActiveRecord::RecordNotFound
      raise ActionController::RoutingError.new("routing error")
    end
  end

  def show
    if current_user.admin?
      @user=User.find(params[:id])
    else
      raise ActionController::RoutingError.new("routing error")
    end
  end

  def new
    if current_user.admin?
      @user=User.new
    else
      raise ActionController::RoutingError.new("routing error")
    end
  end

  def create
    if current_user.admin?
      @user=User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: "ユーザーを登録しました！"
      else
        render 'admin/users/new'
      end
    else
      raise ActionController::RoutingError.new("routing error")
    end
  end

  def edit
    if current_user.admin?
      @user=User.find(params[:id])
    else
      raise ActionController::RoutingError.new("routing error")
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user),
                  notice: "ユーザー「#{@user.user_name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    if current_user.admin?
      @user=User.find(params[:id])
      @user.destroy
      redirect_to admin_users_url,
      notice: "ユーザー「#{@user.user_name}」を削除しました。"
    else
      raise ActionController::RoutingError.new("routing error")
    end
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
