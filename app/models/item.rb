class Item < ApplicationRecord
  
  has_many :cart_items, dependent: :destroy
  has_many :oeder_details, dependent: :destroy
  has_many :orders, through: :ordr_details
  
  belongs_to :genre
  
  has_one_attached :itemimage
  
end
