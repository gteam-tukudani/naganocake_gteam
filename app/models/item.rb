class Item < ApplicationRecord
  
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :oeder_details, dependent: :destroy
  has_many :orders, through: :ordr_details
  
  enum genre_method: { cake: 0, purine: 1, baked_sweets: 2, candy:3 }
  
  def with_tax_price
    (price_excluding_tax * 1.1).floor
  end

end
