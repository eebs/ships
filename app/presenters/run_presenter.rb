class RunPresenter < BasePresenter
  presents :run
  #delegate :username, to: :user

  def icon
    run.ship.type_id? ? ship_icon : placeholder_icon
  end

  def title
    if character_signed_in? && current_character.admin?
      link_to edit_run_path(run), :class => 'admin-link-run-title' do
        title_text
      end
    else
      title_text
    end
  end

  def title_text
    content_tag(:h4, run.ship.name, :class => 'media-heading') + content_tag(:h4, " ##{run.ship_number}", :class => 'media-heading ship-light-text')
  end

  def sell_price
    number_to_currency(run.sell_price) || 'Price Unavailable'
  end

  def started
    "Started: " + run.start_date.to_s(:month_date) if run.start_date.present?
  end

  def status
    run.status.name
  end

  def current_task_time
    unless run.next_due.nil?
      if run.next_due.future?
        out = "Current task finishes in " + home_strong_tag(distance_of_time_in_words_to_now(run.next_due))
      else
        out ="Current task finished " + home_strong_tag(time_ago_in_words(run.next_due)) + " ago"
      end
      out.html_safe
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
    return "- finish time unknown" if run.finish_date.nil?

    if run.finish_date.future?
        out = "- finishes in " + home_strong_tag(distance_of_time_in_words_to_now(run.finish_date))
    else
        out ="- finished " + home_strong_tag(time_ago_in_words(run.finish_date)) + " ago"
    end
    out.html_safe
  end

  def status_body
    character_signed_in? ? signed_in_status_body : public_status_body
  end

  def signed_in_status_body
    if !run.reservation?
      reserve_button
    elsif current_character.admin?
      reserved_by
      view_reservation
    elsif (run.reservation.character == current_character)
      reserved_ago
      view_reservation
    end
  end

  def public_status_body
    sign_in_link
  end

  def sign_in_link
    link_to('Sign in', new_character_session_path) + ' to reserve' unless run.reservation
  end

  def view_reservation
    content_tag(:div, :class => 'ship-light-text') do
      link_to "View Reservation", reservation_path(run.reservation)
    end
  end

  def reserved_ago
    content_tag(:div, :class => 'ship-light-text') do
      'Reserved ' + time_ago_in_words(run.reservation.created_at) + ' ago.'
    end
  end

  def reserved_by
    content_tag(:div, :class => 'ship-light-text') do
      'Reserved by ' + link_to(run.reservation.character.name, character_path(run.reservation.character))
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

  def status_switcher(has_reservation, on_market, not_on_market)
    if run.reservation
      has_reservation
    else
       (run.status == Status.on_market) ?  on_market : not_on_market
    end
  end

  def reserve_button
    link_to 'Reserve', new_reservation_path(:id => run), :class => 'ship-reserve-button btn btn-mini btn-primary'
  end

  def home_strong_tag(content)
    content_tag(:strong, content, :class => 'home-time-strong')
  end
end
