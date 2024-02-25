class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

 validates :name, presence: true
 validates :postal_code, presence: true
 validates :address, presence: true


  #支払い方法
  enum payment_method: {credit_card: 0, transfer: 1}
  #注文ステータス
  enum status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}




  def is_all_order_details_making_completed?
    order_details.all? { |detail| detail.making_status == 'completed' }
  end
end
