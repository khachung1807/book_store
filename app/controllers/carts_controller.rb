class CartsController < ApplicationController
  def index
    @cart = @current_cart
    @cart = Cart.find_by user_id: params[:current_user] if logged_in?
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    flash[:success] = t("delete_cart")
    redirect_to cart_path
  end
end
