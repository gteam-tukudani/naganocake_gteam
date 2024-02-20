class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, only: [:show]

  def index
    @items = Item.page(params[:page])
    @items_all = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private

	def item_params
		params.require(:item).permit(:genre_id, :image ,:name, :introbuction, :price, :is_active)
	end
end