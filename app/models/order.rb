class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart, dependent: :destroy
  def index
  end
end
