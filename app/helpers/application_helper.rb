module ApplicationHelper
    def present(object, klass = nil)
        klass ||= "#{object.class}Presenter".constantize
        presenter = klass.new(object, self)
        yield presenter if block_given?
        presenter
    end

    def is_active?(page_name)
        "active" if params[:controller] == page_name
    end

    def character_image_tag(id, size = 32, options = {})
      image_tag "http://image.eveonline.com/Character/#{id}_#{size}.jpg", options
    end

    # Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "Koprulu Sector"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end
end
