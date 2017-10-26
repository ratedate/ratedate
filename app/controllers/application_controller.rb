class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :capture_referal
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
  private
  def capture_referal
    session[:referred_by] = params[:ref] if params[:ref]
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:referred_by])
  end
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end
  def after_sign_in_path_for(resource)
    if request.subdomain == "ico"
      request.env['omniauth.origin'] || stored_location_for(resource) || ico_account_path(:locale => I18n.locale)
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path(:locale => I18n.locale)
    end
  end
end
