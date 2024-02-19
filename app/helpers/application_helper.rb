module ApplicationHelper
  def get_item_image(item)
    if item.image.attached?
      url_for(item.image)
    else
      asset_path('no_image.jpg')
    end
  end
end
