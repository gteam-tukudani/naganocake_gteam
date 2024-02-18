class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, only: [:show]

  def index
    @items = Item.page(params[:page])
    @items_all = Item.all
  end

  def show
    @item = Item.find_by(id: params[:id])
    if @item
      @cart_item = CartItem.new
    else
      flash[:error] = "Item not found"
      redirect_to items_path
    end
  end


  private

	def item_params
		params.require(:item).permit(:genre_id, :image ,:name, :introbuction, :price, :is_active)
	end
end