class Admin::OrdersController < AdminController
  def index
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context) }
    end
  end
end
