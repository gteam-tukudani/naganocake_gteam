module Admin::ItemsHelper
    def price_with_tax(price)
      (price * 1.1).floor
    end
end
