class CartController < ApplicationController
  before_filter :load_cart

  def add
    @cart.add(params[:photo_id], :size => params[:size])

    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render :layout => false }
    end
  end

  def remove
    @cart.remove(params[:photo_id])

    respond_to do |format|
      format.html { redirect_to @cart }
    end
  end

  def show
  end

  private

  def load_cart
    @cart = Cart.find_or_create_by_session_id(request.session_options[:id])
  end
end
