module ApplicationHelper
    def is_active?(page_name)
        "active" if params[:controller] == page_name
    end

    def character_image_tag(id, size = 32, options = {})
      image_tag "http://image.eveonline.com/Character/#{id}_#{size}.jpg", options
    end
end
