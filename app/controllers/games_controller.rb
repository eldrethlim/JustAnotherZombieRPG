class GamesController < ApplicationController
  before_filter :authenticate_player!, except: [:index]

  def index
    @players = Player.all
    @games = Game.all
  end

  def setup
    @player2 = Player.find(params[:player_id])
    @game = Game.setup(player1: current_player, player2: @player2 )

    if @game
      redirect_to @game, notice: "Brainssssss"
    else
      flash[:error] = "Uh oh, something went wrong creating a game!"
      redirect_to root_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @gridfields = @game.map.gridfields.includes(:gridobject, :character).all
    unless current_player == @game.player1 || current_player == @game.player2
      flash[:error] = "Sorry, you can't access this game!"
      redirect_to root_path
    end
  end

  def last_update
    game = Game.find(params[:id])
    render text: game.last_update.to_s
  end

  def select_character
    if current_character != nil
      current_character.reset_tile(current_character.gridfield)
    end
      gridfield = Gridfield.find(params[:gridfield_id])
      game = Game.find(params[:id])
      character = Character.find(params[:character_id])
      session[:current_character_id] = character.id
      gridfield.update(graphic_url: 'SelectedTile.png')

      flash[:notice] = "Character selected"
      redirect_to game
  end

  def unselect_character
    gridfield = Gridfield.find(params[:gridfield_id])
    game = Game.find(params[:id])
    current_character.reset_tile(gridfield)
    session[:current_character_id] = nil

    flash[:notice] = "Character unselected"
    redirect_to game
  end

  def move_character
    gridfield = Gridfield.find(params[:gridfield_id])
    @game = gridfield.map.game
    @team = @game.current_team

    if current_character.action_points_left?
      @game.latest_update
      current_character.relocate_character(current_character.gridfield, gridfield)
      flash[:notice] = "#{current_character.char_type} moved to #{gridfield.x},#{gridfield.y}!"
    else
      flash[:error] = "Sorry, this character has no action points left!"
    end
    if @team.has_team_action_points?
      end_turn
    else
      redirect_to @game
    end
  end

  def attack_character
    @game = Game.find(params[:id])
    @team = @game.current_team
    @gridfield = Gridfield.find(params[:gridfield_id])
    @character = Character.find(params[:character_id])

    if current_character.action_points_left?
      current_character.consume_action_points
      if current_character.char_type == "Human"
        distance = current_character.can_attack_range?(@gridfield)
        @character.hit_chance(distance)
        @game.perform_attack(@character, current_character)
      else
        @game.perform_attack(@character, current_character)
      end

      if @character.check_if_dead
        flash[:notice] = "#{current_character.char_type} attacked #{@character.char_type} for #{current_character.attack_damage} damage! #{@character.char_type} died!"
      else
        flash[:notice] = "#{current_character.char_type} attacked #{@character.char_type} for #{current_character.attack_damage} damage!"
      end
    else
      flash[:error] = "Sorry, this character has no action points left!"
    end

    if @team.has_team_action_points?
      end_turn
    else
      redirect_to @game
    end
  end

  def end_turn_button
    @game = Game.find(params[:id])
    @team = @game.current_team

    end_turn
  end
  
  def end_turn
    @characters = @team.characters
    @game.latest_update
    @game.process_end_turn(@characters)

    flash[:alert] = "Your turn has ended!"
    redirect_to @game
  end

  private

  def current_character
    if session[:current_character_id] != nil
      @current_character ||= Character.find_by_id(session[:current_character_id])
    else
      @current_character ||= nil
    end
  end
  helper_method :current_character
end