class OrdersDatatable
  delegate :params, :h, :link_to, :mail_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Order.count,
      iTotalDisplayRecords: orders.total_entries,
      aaData: data
    }
  end

private

  def data
    orders.map do |order|
      [
        h(order.created_at.to_s(:short)),
        mail_to(order.buyer_email),
        h(order.line_items.count),
        h(number_to_currency(order.total)),
        order.payment_status
      ]
    end
  end

  def orders
    @orders ||= fetch_orders
  end

  def fetch_orders
    orders = Order.order("#{sort_column} #{sort_direction}")

    orders = orders.page(page).per_page(per_page)
    if params[:sSearch].present?
      orders = orders.
        where("buyer_email like :search",
              search: "%#{params[:sSearch]}%")
    end

    orders
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at buyer_email line_items_count total payment_status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
