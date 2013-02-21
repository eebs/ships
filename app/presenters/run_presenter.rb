class RunPresenter < BasePresenter
  presents :run
  #delegate :username, to: :user

  def icon
    run.ship.type_id? ? ship_icon : placeholder_icon
  end

  def title
    content_tag(:h4, run.ship.name, :class => 'media-heading') + content_tag(:h4, " ##{run.ship_number}", :class => 'media-heading ship-light-text')
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