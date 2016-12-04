class Admin::OrdersController < Admin::BaseController
  def index
    @page_size = Kuli::Application::PAGE_SIZE
    @current_page = params[:page].present? ? params[:page].to_i : 0
    @orders_count = Order.count
    @orders = Order.offset(@current_page * @page_size).limit(@page_size)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    Order.find(params[:id]).destroy!
    redirect_to action: 'index'
  end
end
