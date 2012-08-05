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
    send_file @order.to_zip, type: "application/zip"
  end

  private

  def load_orders
    @orders = current_user.orders.order('id desc')
  end
end
