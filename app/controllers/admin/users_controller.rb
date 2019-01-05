# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_adm

  def index
    @user = User.all.order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'admin/users/new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'admin/users/edit'
    end
  end

  def show; end

  def destroy
    admin_num = User.where(admin: true).size
    if @user.admin? && (admin_num == 1)
      flash[:notice] = "can't delete admin\nBecause admin must exist 1 user"
    else
      @user.destroy
    end
    redirect_to admin_users_path
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
