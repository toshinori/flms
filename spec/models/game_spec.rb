require 'spec_helper'
require 'shared_examples.rb'

describe Game do

  it_behaves_like :when_model_is_new, Game.new
  it_behaves_like :when_model_is_valid, FactoryGirl.create(:game_base, valid: true)

  describe 'association' do
    it { should belong_to(:home_team) }
    it { should belong_to(:away_team) }
    it { should have_many(:progresses) }
  end

  context 'when set same team id' do
    subject {
      team = FactoryGirl.create(:team_base)
      Game.new({ home_team_id: team.id, away_team_id: team.id })
    }
    its(:valid?) { should_not be_true }
    its(:save) { should_not be_true }
  end

end
