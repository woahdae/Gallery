class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_orders
  load_and_authorize_resource

  def show
  end

  def index
    if @orders.any?
      redirect_to @orders.first
    else
      render
    end
  end

  def download
    respond_to do |format|
      format.js do
        expired = @order.download_url.try(:match, /expired/)
        valid = URI.parse(@order.download_url || '').scheme
        if valid
          render :json => {status: 'valid', url: @order.download_url}.to_json
        elsif expired
          render :json => {status: 'expired'}.to_json
        else # not done yet
          render :json => {status: 'pending'}.to_json
        end
      end
    end
  end

  private

  def load_orders
    @orders = current_user.orders.order('id desc')
  end
end
