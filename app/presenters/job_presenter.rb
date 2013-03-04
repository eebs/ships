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
end