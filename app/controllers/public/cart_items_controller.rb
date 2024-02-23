class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "商品を削除しました。"
     redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    flash[:notice] = "カート内の商品をすべて削除しました。"
     redirect_to cart_items_path
  end

  def create
  # 数量が選択されているかどうかのチェック
    if params[:cart_item][:amount].blank?
    flash[:notice] = '数量を選択してください。'  
    redirect_to item_path(params[:cart_item][:item_id]) and return
    end
  
    # 既存のカートアイテムの有無のチェック
    # cart_item.customer_id = current_customer.id
    # cart_item.item.id = cart_item_params[:item_id]
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
      else
        redirect_to cart_items_path
      end
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
