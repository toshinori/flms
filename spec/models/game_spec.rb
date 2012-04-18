require 'spec_helper'

describe Game do

  context 'when new' do
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  context 'can save' do
    subject {
      home = FactoryGirl.create(:team_base)
      away = FactoryGirl.create(:team_base)
      Game.new({ home_team_id: home.id, away_team_id: away.id })
    }
    its(:valid?) { should be_true }
    its(:save) { should_not be_false }
  end

  context 'home and away is same teams' do
    subject {
      team = FactoryGirl.create(:team_base)
      Game.new({ home_team_id: team.id, away_team_id: team.id })
    }
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end
end
