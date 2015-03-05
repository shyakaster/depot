class ApplicationController < ActionController::Base

  before_action :set_date_loaded
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def set_date_loaded
    @date_loaded = Time.now
  end

  protected

  def increment_session_counter
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end
end
