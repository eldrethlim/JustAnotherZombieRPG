class GamesController < ApplicationController
  before_filter :authenticate_player!
end
