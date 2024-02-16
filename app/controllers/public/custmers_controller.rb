class Public::CustmersController < ApplicationController

  def show
    @custmer = current_custmer
  end

  def edit
    @custmer = current_custmer
  end

  def update
  end

  def destroy
  end

  private
  def custmer_params
    params.require(:custmer).parmit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
