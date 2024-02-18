class Item < ApplicationRecord
  
  has_one_attached :item_image
  
  has_many :cart_items, dependent: :destroy
  has_many :oeder_details, dependent: :destroy
  has_many :orders, through: :ordr_details
  
  belongs_to :genre
  
  enum genre_method: { cake: 0, purine: 1, baked_sweets: 2, candy:3 }
  
end
