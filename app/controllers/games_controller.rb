class GamesController < ApplicationController
  before_filter :authenticate_player!, except: [:index]

  def index
    @players = Player.all
  end

  def setup
    redirect_to root_path
  end
end
