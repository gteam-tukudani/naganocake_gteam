class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
