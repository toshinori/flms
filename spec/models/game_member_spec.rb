require 'spec_helper'
require 'shared_examples'

describe GameMember do
  it_behaves_like :when_model_is_new, GameMember.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_member_player)

  let(:valid_model) { FactoryGirl.build(:game_member_player) }

  describe 'associations' do
    it { should belong_to(:team) }
    it { should belong_to(:master) }
    it { should belong_to(:position) }
    it { should have_many(:fouls) }
    it { should have_many(:goals) }
    it { should have_many(:substitutions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:game_team_id) }
    it { should validate_presence_of(:member_id) }
  end

  describe 'starting_status' do
    it { should ensure_inclusion_of(:starting_status).in_range(Constants.starting_status.values) }

    it_behaves_like :not_invalid_after_attr_change, :starting_status, { nil: nil } do
      let(:target_model) { valid_model }
    end
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

  context 'when set starting player' do
    subject { FactoryGirl.create(:game_member_player, { starting_status: Constants.starting_status.starting }) }
    its(:starting_player?) { should be_true }
    its(:reserve_player?) { should_not be_true }
  end

  context 'when set reserve player' do
    subject { FactoryGirl.create(:game_member_player, { starting_status: Constants.starting_status.reserve}) }
    its(:starting_player?) { should_not be_true }
    its(:reserve_player?) { should be_true }
  end

  context 'when set manager' do
    subject { FactoryGirl.create(:game_member_manager) }
    its(:player?) { should_not be_true }
    its(:manager?) { should be_true }
    its(:starting_player?) { should_not be_true }
    its(:reserve_player?) { should_not be_true }
  end

  context 'when starting_player is over' do
    subject {
      game = FactoryGirl.create(:game_can_start)
      player = create(:player)
      GameMember.new(
        game_team_id: game.home_team.id,
        member_id: player.id,
        starting_status: Constants.starting_status.starting
      )

    }
    its(:valid?) { should_not be_true }
    its(:save) { should_not be_true }
  end
end
