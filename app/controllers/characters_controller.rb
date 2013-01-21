class CharactersController < ApplicationController
  load_and_authorize_resource

  def index
    @characters = Character.all
  end
end