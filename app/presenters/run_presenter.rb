class RunPresenter < BasePresenter
  presents :run
  #delegate :username, to: :user

  def icon
    if run.ship.type_id?
      ship_icon
    else
      placeholder_icon
    end
  end

private

  def ship_icon
    icon_image "http://image.eveonline.com/InventoryType/#{run.ship.type_id}_64.png"
  end

  def placeholder_icon
    icon_image "placeholder.jpg", :height => 64, :width => 64
  end

  def icon_image(src, options = {})
    options.merge! :class => 'media-object'
    image_tag src, options
  end
end