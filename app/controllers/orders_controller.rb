class OrdersController < ApplicationController
  before_filter :authenticate_user!
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
end
