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
      if @order.confirm_payment?
        @order.order_details.each do |detail|
          detail.update!(making_status: :waiting_manufacture)
        end
      end
      redirect_to admin_order_path(@order), notice: '注文ステータスが更新されました。'
    else
      render :show, alert: '注文ステータスの更新に失敗しました。'
    end
  end



private

  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method,:status)
  end
end