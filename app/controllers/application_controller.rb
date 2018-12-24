class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  before_action :login_required

  NOT_YET = "未着手".freeze
  START = "着手".freeze
  COMPLETE= "完了".freeze


  protect_from_forgery with: :exception
  include SessionsHelper

  # 例外処理
#rescue_from ActiveRecord::RecordNotFound, with: :render_404
#rescue_from ActionController::RoutingError, with: :render_404
#rescue_from Exception, with: :render_500

#  always add prefix I18n
#  delegate :t, to: :I18n

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false, content_type: 'text/html'
  end

  def render_500
    render file: "#{Rails.root}/public/500.html", status: 500, layout: false, content_type: 'text/html'
  end

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

end
