# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :login_required
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash.now[:danger] = 'login failed'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash.now[:notice] = 'logout'
    redirect_to new_session_path
  end
end
