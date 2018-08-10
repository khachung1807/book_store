class CartItemsController < ApplicationController
  before_action :find_cart_item, only: [:update, :destroy]

  def create
    chosen_book = Book.find_by id: params[:book_id]
    if chosen_book.present?
      current_cart = @current_cart

      if current_cart.books.include? chosen_book
        @cart_item = current_cart.cart_items.find_by book_id: chosen_book
        @cart_item.quantity += 1
      else
        @cart_item = CartItem.new
        @cart_item.cart = current_cart
        @cart_item.book = chosen_book
        @cart_item.quantity = 1
      end

      @cart_item.save
      redirect_to cart_path
    else
      flash[:danger] = t("book_not_found")
      redirect_to root_path
    end
  end

  def update
    @cart_item.quantity += 1 if params[:check] == "0"

    @cart_item.quantity -= 1 if params[:check] == "1" && @cart_item.quantity > 1

    @cart_item.save
    redirect_to cart_path
  end

  def destroy
    @cart_item.destroy
    flash[:success] = t("delete_cart_item")
    redirect_to cart_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit :quantity, :book_id, :cart_id
  end

  def find_cart_item
    @cart_item = CartItem.find_by id: params[:id]

    return if @cart_item.present?
    flash[:danger] = t("cart_item_not_found")
    redirect_to cart_path
  end
end
