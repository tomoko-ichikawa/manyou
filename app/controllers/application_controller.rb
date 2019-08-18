class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false, content_type: 'text/html'
  end

  def render_500
    render file: "#{Rails.root}/public/500.html", status: 500, layout: false, content_type: 'text/html'
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to new_session_path unless current_user
  end
end
