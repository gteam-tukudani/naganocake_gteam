class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_id] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_id] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:address_id] == "2"
      @order.current_customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Order.new
      render :confirm
  end

  def create
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all


  end

  def index
    @orders = Order.all
    @customer = current_customer
  end

  def show
  end


private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
