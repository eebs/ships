class RunPresenter < BasePresenter
  presents :run
  #delegate :username, to: :user

  def icon
    run.ship.type_id? ? ship_icon : placeholder_icon
  end

  def title
    content_tag(:h4, run.ship.name, :class => 'media-heading') + content_tag(:h4, " ##{run.ship_number}", :class => 'media-heading ship-light-text')
  end

  def sell_price
    number_to_currency(run.sell_price) || 'Price Unavailable'
  end

  def started
    "Started: " + Time.zone.parse(run.start_date).to_s(:month_date) if run.start_date.present?
  end

  def status
    run.status.name
  end

  def current_task_time
    unless run.next_due.empty?
      due = Time.zone.parse(run.next_due)
      if due.future?
          "Current task finishes in " + distance_of_time_in_words_to_now(due)
      else
          "Current task finished " + time_ago_in_words(due) + " ago"
      end
    end
  end

  def last_updated
    'Last updated ' + time_ago_in_words(run.updated_at) + ' ago'
  end

  def status_color
    status_switcher '#FF0000', '#00FF00', '#0000FF'
  end

  def status_header
    status_switcher 'Reserved', 'Available', 'In Progress'
  end

  def finishes_in
    return "- finish time unknown" unless run.eta
    
    if run.eta.future?
        "- finishes in " + distance_of_time_in_words_to_now(run.eta)
    else
        "- finished " + time_ago_in_words(run.eta) + " ago"
    end
  end

  def sign_in_link
    link_to('Sign in', new_character_session_path) + ' to reserve' unless run.reservation
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

  def status_switcher(has_reservation, on_market, not_on_market)
    if run.reservation
      has_reservation
    else
       (run.status == Status.on_market) ?  on_market : not_on_market
    end
  end
end