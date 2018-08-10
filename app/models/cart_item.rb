class CartItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  def total_price
    quantity * book.price
  end
end
