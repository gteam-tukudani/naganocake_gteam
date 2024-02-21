class Admin::OrdersController < ApplicationController

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
  end

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "wait_payment"
        @order.order_details.update_all(manufacture_status: :waiting_manufacture)
      #elsif @order.order_details.all? { |detail| detail.manufacturing? }
        #@order.update(status: :making)
      #elsif @order.order_details.all? { |detail| detail.finish? }
        #@order.update(status: :preparing_ship)
      end
      redirect_back(fallback_location: root_path, notice: '注文ステータスが更新されました。')
    else
      render :show, alert: '注文ステータスの更新に失敗しました。'
    end
end


private

  def order_params
      params.require(:order).permit(:status)
  end
end