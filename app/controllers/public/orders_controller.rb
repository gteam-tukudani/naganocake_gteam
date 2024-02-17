class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
  end

end
