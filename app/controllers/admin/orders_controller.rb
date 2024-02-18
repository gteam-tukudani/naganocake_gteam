class Admin::OrdersController < ApplicationController
  
  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
  end
  
  def show
  end
  
  def update
  end
end
