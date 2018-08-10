class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :set_locale
  before_action :current_cart

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by id: session[:cart_id]
      cart.present? ? @current_cart = cart : session[:cart_id] = nil
    else
      if logged_in?
        current_user.build_cart
      else
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    end
  end
end
