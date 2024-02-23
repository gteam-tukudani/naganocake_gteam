class Public::OrdersController < ApplicationController

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
    elsif params[:order][:address_option] == "2"
       @order.current_customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      render :confirm
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = :wait_payment
    @cart_items = current_customer.cart_items
<<<<<<< HEAD
    case params[:order][:address_option].to_i
    when 0
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
    when 1
      @address = Address.find(params[:order][:address_option])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    when 2
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
=======
>>>>>>> 64b5a251026e964f29352bc323a7cec20f2899a1
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
    @orders = Order.all
    @customer = current_customer
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
