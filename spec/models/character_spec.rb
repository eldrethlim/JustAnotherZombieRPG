require 'rails_helper'

RSpec.describe Character, :type => :model do
  describe '#can_move_to?' do
    let(:p1) { FactoryGirl.create(:player) }
    let(:p2) { FactoryGirl.create(:player) }

    before do 
      @game = Game.setup(player1: p1, player2: p2)
      @character = @game.team1.characters.first # x=12, y=1
    end

    it 'should return true for adjacent field' do
      gridfield = @game.map.gridfields.where(x: 13, y: 1).first
      expect(@character.can_move_to?(gridfield)).to eq(true)
    end

    it "should return false for field that is further than character's speed" do
      speed = @character.speed
      gridfield = @game.map.gridfields.where(x: 13, y: speed + 2).first
      expect(@character.can_move_to?(gridfield)).to eq(false)
    end
  end
end
