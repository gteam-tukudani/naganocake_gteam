class Public::ItemsController < ApplicationController
  
  before_action :authenticate_customer!, only: [:show]

  def index
    @item = Item.page(params[:page])
    @items = Item.all
      @genres = Genre.all
    if params[:genre_id].present?
      @items = Item.where(genre_id: params[:genre_id])
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
    if params[:genre_id].present?
      @items = Item.where(genre_id: params[:genre_id])
    else
      @items = Item.all
    end
  end


  private

	def item_params
		params.require(:item).permit(:genre_id, :image ,:name, :introduction, :price, :is_active)
	end
end