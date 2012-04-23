require 'spec_helper'
require 'shared_examples'

describe GameTeam do
  it_behaves_like :when_model_is_new, GameTeam.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_team_home)

  # it_behaves_like :when_model_is_valid, FactoryGirl.create(:team_base)
  describe 'associations' do
    it { should belong_to(:game) }
    it { should belong_to(:team) }
    it { should have_many(:members) }
  end

  describe 'validations' do
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:team_id) }
    it { should ensure_inclusion_of(:home_or_away).in_range(GameTeam::HomeOrAway.values)}
    # it { should validate_uniqueness_of(:game_id).scoped_to(:team_id) }
  end

  context 'when save' do
    pending 'game - game_team associaions changing'
    # subject { FactoryGirl.create(:game_team_home) }
    # its(:name) { should_not be_blank}
  end
end
