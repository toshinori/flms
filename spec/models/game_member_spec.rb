require 'spec_helper'
require 'shared_examples'

describe GameMember do
  it_behaves_like :when_model_is_new, GameMember.new

  describe 'associations' do
    it { should belong_to(:team) }
    it { should belong_to(:master) }
    it { should belong_to(:position) }
    it { should have_many(:fouls) }
    it { should have_many(:goals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:game_team_id) }
    it { should validate_presence_of(:member_id) }
    it { should ensure_inclusion_of(:starting_status).in_range(Constants.starting_status.values) }
  end

  context 'after save' do
    subject { FactoryGirl.create(:game_member_player) }
    its(:first_name) { should_not be_blank }
    its(:last_name) { should_not be_blank }
  end

  context 'when set player' do
    subject { FactoryGirl.create(:game_member_player) }
    its(:player?) { should be_true }
    its(:manager?) { should_not be_true }
  end

  context 'when set manager' do
    subject { FactoryGirl.create(:game_member_manager) }
    its(:player?) { should_not be_true }
    its(:manager?) { should be_true }
  end
end
