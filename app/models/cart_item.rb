class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :customer
    
    has_one_attached :image
    
  def with_tax_price
    (price * 1.1).floor
  end

    has_one_attached :image

  def subtotal
      item.with_tax_price * amount
  end

end
