class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_orders
  load_and_authorize_resource

  def show
  end

  def index
    redirect_to @orders.first
  end

  private

  def load_orders
    @orders = current_user.orders.order('id desc')
  end
end
