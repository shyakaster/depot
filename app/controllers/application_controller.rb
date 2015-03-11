class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_date_loaded
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def set_date_loaded
    @date_loaded = Time.now
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  protected

  def increment_session_counter
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end

    def authorize
      unless request.format == Mime::HTML
        authenticate_or_request_with_http_basic do |n, p|
          user = User.find_by_name(n)
          if user and user.authenticate(p)
            session[:user_id] = user.id
          end
        end
      else
        return if User.count.zero?
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end
      end
    end
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
            "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
 end
