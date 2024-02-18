class Item < ApplicationRecord
  
  has_many :cart_items, dependent: :destroy
  has_many :oeder_details, dependent: :destroy
  has_many :orders, through: :ordr_details
  
  belongs_to :genre
  
  has_one_attached :item_image

  def with_tax_price
    (price_excluding_tax * 1.1).floor
  end
end
