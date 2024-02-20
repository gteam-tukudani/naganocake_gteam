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
    @cart_items = CartItem.all
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
     render 'index'
  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
     render 'index'
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    # cart_item.customer_id = current_customer.id
    # cart_item.item.id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i

      # cart_item.update(amount: cart_item.amount)
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      render 'index'
    else
      render 'index'

    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
