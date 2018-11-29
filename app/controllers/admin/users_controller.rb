class Admin::UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :show, :destroy]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_user)
    if @user.save
      redirect_to admin_user_path
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def set_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    
  end

end
