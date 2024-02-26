class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:address_option] == "2" && params[:order][:postal_code].present? && params[:order][:address].present? && params[:order][:name].present?
       @order.customer_id = current_customer.id
    else
       @addresses = current_customer.addresses
       flash[:notice] = "必要な情報を入力してください。"
       render :new
    end
    @cart_items = current_customer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = :wait_payment
    @cart_items = current_customer.cart_items

    if @order.save
      @cart_items.each do |item|
        order_details = OrderDetail.new
        order_details.order_id = @order.id
        order_details.item_id = item.item.id
        order_details.price = item.item.price
        order_details.amount = item.amount
        order_details.making_status = 0
        order_details.save
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      @addresses = Address.all
      render :new
    end


  end

  def thanks
  end

  def index
    @customer = current_customer
    @orders = @customer.orders.all

  end

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end


private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
