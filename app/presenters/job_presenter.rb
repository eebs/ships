class JobPresenter < BasePresenter
  presents :job
  #delegate :username, to: :user

  def icon
    image_tag "http://image.eveonline.com/InventoryType/#{job.outputTypeID}_32.png", :class => 'media-object'
  end

  def item_name
    api = EveApi.new
    api.type_name(job.outputTypeID)
  end

  def character_name
    api = EveApi.new
    api.char_name(job.installerID)
  end

  def status
    finishes.future? ? "finishes in #{distance_of_time_in_words_to_now(finishes)}" : "Ready"
  end

  def status_class
    finishes.past? ? "ready" : 'in-progress'
  end

  def progress_bar
    content_tag :div, :class => "progress progress-striped #{progress_color}" do
      content_tag :div, '', :class => 'bar', :style => progress_bar_style
    end    
  end

  def start_time
    Time.zone.parse(job.beginProductionTime)
  end

  def end_time
    Time.zone.parse(job.endProductionTime)
  end

private

  def finishes
    Time.zone.parse(job.endProductionTime)
  end

  def percent_complete
    total = end_time - start_time
    total = (total == 0) ? 1 : total
    completed = Time.zone.now - start_time
    (completed/total)*100
  end

  def progress_bar_style
    "width: #{percent_complete}%;"
  end

  def progress_color
    if finishes.past?
      'progress-success'
    else
      'progress-warning'
    end
  end
end
