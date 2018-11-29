class Admin::UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :show, :destroy]
  before_action :require_adm

  def index
    @user = User.all.order(created_at: :asc).includes(:tasks)
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
    if User.where(admin: true).count > 1
      @user.destroy
      redirect_to admin_users_path
    else
      flash[:notice] = "can't delete admin\nBecause admin must exist 1 user"
      redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def require_adm
    unless current_user.admin?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
