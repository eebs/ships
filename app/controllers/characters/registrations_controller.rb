class Characters::RegistrationsController < Devise::RegistrationsController

  before_filter :check_trust, :only => :create

  def new
    logger.warn "Trusted: " + ((igb.trusted? == true) ? 'yes' : 'no')
    logger.warn "From header: " + request.headers.inspect
    @already_registered = Character.find_by_name(igb.char_name)
    super
  end

  def create
    # Use name and id from IGB
    params[:character][:name] = igb.char_name
    params[:character][:characterid] = igb.char_id
    super
  end

  def update
    # Don't allow user to change name or id
    params[:character].delete(:name)
    params[:character].delete(:characterid)
    super
  end

private

  def check_trust
    if igb? && !igb.trusted?
      flash[:error] = "You must use the in-game browser, and trust this site to register."
      redirect_to new_character_registration_url
    end
  end
end