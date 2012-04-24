require 'spec_helper'
require 'shared_examples.rb'

describe Game do

  it_behaves_like :when_model_is_new, Game.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_base)

  describe 'associations' do
    it { should have_many(:teams) }
    it { should have_many(:progresses) }
    it { should have_one(:home_team) }
    it { should have_one(:away_team) }
  end

  describe 'validations' do
    it { should validate_presence_of(:the_date) }
  end

end
