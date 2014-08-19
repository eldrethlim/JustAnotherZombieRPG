require 'rails_helper'

RSpec.describe Game, :type => :model do
  describe '.setup' do
    let(:p1) { FactoryGirl.create(:player) }
    let(:p2) { FactoryGirl.create(:player) }

    it 'should make a new Game record in the DB' do
      expect {
        Game.setup(player1: p1, player2: p2)
      }.to change(Game, :count).by(1)
    end

    it 'should return the newly created Game object' do
      game = Game.setup(player1: p1, player2: p2)
      expect(game).to eq(Game.last)
    end

    it 'should pass player info and save it as well' do
      Game.setup(player1: p1, player2: p2)
      expect(Game.last.player1).to eq(p1)
      expect(Game.last.player2).to eq(p2)
    end

    it 'should make a new Map record in the DB related to the game' do
      expect {
        Game.setup(player1: p1, player2: p2)
      }.to change(Map, :count).by(1)
      expect(Game.last.map).to eq(Map.last)
    end

    it 'should make a map with 900 unique grid fields' do
      expect {
        Game.setup(player1: p1, player2: p2)
      }.to change(Gridfield, :count).by(900)
      fields = Gridfield.all.map {|gf| [gf.x, gf.y]}
      expect(fields).to eq(fields.uniq)
      Gridfield.all.each do |gf|
        expect(gf.map_id).to eq(Map.last.id)
      end
    end

    it 'should put traversible floor grid object on each field' do
      expect {
        Game.setup(player1: p1, player2: p2)
      }.to change(Gridobject, :count).by(900)
      Gridobject.all.each do |go|
        expect(go.traversible).to eq(true)
      end
      fields = Gridobject.all.map {|go| gf = go.gridfield; [gf.x, gf.y]}
      expect(fields).to eq(fields.uniq)
    end

    it 'should put one character within the team on the map' do 
      game = Game.setup(player1: p2, player2: p2)
      team = game.team1
      expect(team).to_not be_nil
      expect(team.characters.count).to eq(1)
      char = team.characters.first
      expect(char.graphic_url).to eq('Soldier160x160withgrass.png')
      expect(char.gridfield).to_not be_nil
      expect(char.gridfield.x).to eq(1)
      expect(char.gridfield.y).to eq(1)
    end
  end
end