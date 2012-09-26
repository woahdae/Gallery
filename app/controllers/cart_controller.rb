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

  def update
    if @cart.update_attributes(params[:cart])
      respond_to do |format|
        format.html { redirect_to cart_path }
      end
    else
      respond_to do |format|
        format.html { render action: 'show' }
      end
    end
  end

  private

  def load_cart
    @cart = Cart.find_or_create_by_session_id(request.session_options[:id])
  end
end
