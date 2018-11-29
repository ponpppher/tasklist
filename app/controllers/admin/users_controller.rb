class Admin::UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :show, :destroy]

  def index
    @user = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render "admin/users/new"
    end

  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render "admin/users/edit"
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest)
  end

end
