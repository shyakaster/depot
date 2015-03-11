class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    increment_session_counter
    @products = Product.order(:title)
  end

end
