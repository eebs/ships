class Characters::RegistrationsController < Devise::RegistrationsController

  before_filter :check_trust, :only => :create

  def new
    @already_registered = Character.find_by_name(igb.char_name)
    super
  end

  def create
    # Use name and id from IGB
    params[:character][:name] = igb.char_name
    params[:character][:characterid] = igb.char_id

    super

    notify :admins do |notifier|
      character = Character.find_by_characterid params[:character][:characterid]
      message = NewCharacterMessage.create!(:title => "New character registration")
      message.character_id = character.id
      notifier.message = message
    end.send
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
