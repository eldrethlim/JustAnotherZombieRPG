class PlayersController < ApplicationController
  before_filter :authenticate_player!

  def update
    if current_player.update_attributes(player_params)
      flash[:notice] = "Account information updated!"
    end
    redirect_to edit_player_registration_path(current_player)
  end

  private

  def player_params
    params.require(:player).permit(:username, :email)
  end
end