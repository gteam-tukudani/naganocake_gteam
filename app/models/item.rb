class Item < ApplicationRecord

  has_one_attached :image

  has_many_attached :images 
  has_many :cart_items, dependent: :destroy
  has_many :oeder_details, dependent: :destroy
  has_many :orders, through: :ordr_details

  belongs_to :genre

   validates :price, presence: true, numericality: { greater_than: 0 }

   def with_tax_price
    (price * 1.1).floor
   end

end
