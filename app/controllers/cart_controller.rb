class CartController < ApplicationController
  before_filter :load_cart

  def add
    @cart.add(params[:photo_id])
  end

  def remove
    @cart.remove(params[:photo_id])

    respond_to do |format|
      format.html { redirect_to @cart }
    end
  end

  private

  def load_cart
    @cart = Cart.find_or_create_by_session_id(request.session_options[:id])
  end
end
