class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  before_action :login_required

  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def login_required
    redirect_to new_session_path unless current_user
  end
  
end
