class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      order = @order_detail.order
      if order.order_details.any? { |detail| detail.making_status == "making" }
        order.update!(status: :making)
      end

      if order.order_details.all? { |detail| detail.making_status == "finish" }
        order.update!(status: :preparing_ship)
      end

      flash[:notice] = "製作ステータスを更新しました。"
      redirect_to admin_order_path(@order_detail.order)
    else
      flash[:alert] = "製作ステータスの更新に失敗しました。"
      render 'admin/orders/show'
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
