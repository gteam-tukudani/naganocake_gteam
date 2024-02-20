class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.all
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end

  def destroy_all
    CartItem.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item.item.id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_item_path(cart_item)
    else
      cart_item.save
      redirect_to item_path
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
