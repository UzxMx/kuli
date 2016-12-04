class OrdersController < ApplicationController
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @page_size = Kuli::Application::PAGE_SIZE
    @current_page = params[:page].present? ? params[:page].to_i : 0
    @orders = Order.where(user: current_user).offset(@current_page * @page_size).limit(@page_size)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.where(id: params[:id], user: current_user).first
  end

  # GET /orders/new
  def new
    @products = Product.all
  end

  # POST /orders
  # POST /orders.json
  def create
    @products = Product.all
    order_products = []
    @products.each do |p|
      sym = "product_#{p.id}".to_sym
      if params[sym].present?
        count = params[sym].to_i
        if count > 0
          order_product = OrderProduct.new(product: p, count: count)
          order_products << order_product
        end
      end
    end

    if order_products.size > 0
      order = Order.new(user: current_user)
      order.save!
      order_products.each do |i|
        i.order = order
        i.save!
      end
      redirect_to order_path(order.id)
    else
      redirect_to new_order_path
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    Order.where(id: params[:id], user: current_user).first.destroy!
    redirect_to action: 'index'
  end
end
