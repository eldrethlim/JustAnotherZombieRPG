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
      current_character.gridfield.update(graphic_url: 'GrassTile.png')
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
    session[:current_character_id] = nil
    gridfield.update(graphic_url: 'GrassTile.png')

    flash[:notice] = "Character unselected"
    redirect_to game
  end

  def move_character
    gridfield = Gridfield.find(params[:gridfield_id])
    @game = gridfield.map.game
    @team = @game.current_team


    if current_character.action_points_left > 0
      current_character.update(action_points_left: current_character.action_points_left - 1)
      update_latest_action(@game)
      if current_character.gridfield.someone_died_here == true
        current_character.gridfield.update(character_id: nil, graphic_url: 'DeadChar.png')
      else
        current_character.gridfield.update(character_id: nil, graphic_url: 'GrassTile.png')
      end
      gridfield.update(character_id: current_character.id, graphic_url: 'SelectedTile.png')
      flash[:notice] = "#{current_character.char_type} moved to #{gridfield.x},#{gridfield.y}!"
    else
      flash[:error] = "Sorry, this character has no action points left!"
    end

    check_team_action_points
  end

  def attack_character
    @game = Game.find(params[:id])
    @team = @game.current_team
    @gridfield = Gridfield.find(params[:gridfield_id])
    @character = Character.find(params[:character_id])

    if current_character.char_type == "Human"
      distance = current_character.can_attack_range?(@gridfield)
      hit = rand(99) + 1
      if distance >= 6 && hit > 30
        perform_attack
      elsif distance.between?(3, 5) && hit > 20
        perform_attack
      elsif distance < 3
        perform_attack
      else
        flash[:error] = "#{current_character.char_type} missed attack on #{@character.char_type}!"    
      end
    else
      perform_attack
    end

    check_team_action_points
  end

  def end_turn_button
    @game = Game.find(params[:id])
    @team = @game.current_team

    end_turn
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

  def perform_attack
    if current_character.action_points_left > 0
      update_latest_action(@game)
      current_character.update(action_points_left: current_character.action_points_left - 1)
      @character.update(life_points_left: @character.life_points_left - current_character.attack_damage)
      if @character.life_points_left <= 0
        @character.gridfield.update(graphic_url: 'DeadChar.png', someone_died_here: true)
        @character.destroy
        flash[:notice] = "#{current_character.char_type} attacked #{@character.char_type} for #{current_character.attack_damage} damage! #{@character.char_type} died!"
      else
        flash[:notice] = "#{current_character.char_type} attacked #{@character.char_type} for #{current_character.attack_damage} damage!"
      end 
    else
      flash[:error] = "Sorry, this character has no action points left!"
    end
  end

  def check_team_action_points

    total = Array.new

    @team.characters.each do |character|
      total.push character.action_points_left
    end

    if total.inject(:+) == 0
      end_turn
    else
      redirect_to @game
    end
  end

  def end_turn
    @characters = @team.characters
    @characters.each do |character|
      character.update(action_points_left: 2) 
    end
    update_latest_action(@game)
    
    @game.map.gridfields.where(graphic_url: 'SelectedTile.png').each do |gridfield|
      gridfield.update(graphic_url: 'GrassTile.png')
    end

    if @game.current_player_turn_id == @game.player1.id
      @game.update(current_player_turn_id: @game.player2.id)
    else
      @game.update(current_player_turn_id: @game.player1.id)
    end

    flash[:alert] = "Your turn has ended!"
    redirect_to @game
  end

  def update_latest_action(game)
    game.update(last_update: Time.now)
  end
end