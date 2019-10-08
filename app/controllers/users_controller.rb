class UsersController < ApplicationController
  #ユーザー登録時のみ、このアクションはかからない
  skip_before_action :login_required

  def new
      @user=User.new
  end

  def create
    @user=User.new(user_params)
      if @user.save
        session[:user_id] = @user.id unless current_user
        redirect_to user_path(@user.id)
      else
        render 'new'
      end
  end

  def show
    @user=User.find(params[:id])
    redirect_to tasks_path unless @user==current_user
    @groups = @user.groups
    @favorite_groups = @user.favorite_groups
  end

  private

  def user_params
     params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

end
