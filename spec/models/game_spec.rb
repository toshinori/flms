require 'spec_helper'
require 'shared_examples.rb'

describe Game do

  it_behaves_like :when_model_is_new, Game.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_base)

  describe 'associations' do
    it { should have_many(:teams) }
    it { should have_one(:home_team) }
    it { should have_one(:away_team) }
    it { should have_many(:fouls) }
    it { should have_many(:goals) }
    it { should have_many(:substitutions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:the_date) }
  end

  describe 'home_team' do
    pending 'have not desigined.'
  end

  describe 'away_team' do
    pending 'have not desigined.'
  end
end
