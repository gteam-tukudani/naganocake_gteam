class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new   
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
end
