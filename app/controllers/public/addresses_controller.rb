class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = current_customer
    @addresses = @customer.addresses.all
    @address = Address.new

  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash.now[:notice] = '登録が完了しました。'
      redirect_to addresses_path
    else
      @addresses = Address.all
      flash.now[:notice] = '配送先の登録に失敗しました。入力内容を確認してください。'
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
