class Public::AddressesController < ApplicationController
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
