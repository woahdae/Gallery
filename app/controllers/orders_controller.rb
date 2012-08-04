class OrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
  end
end
