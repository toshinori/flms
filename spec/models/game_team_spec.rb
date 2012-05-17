require 'spec_helper'
require 'shared_examples'

describe GameTeam do
  it_behaves_like :when_model_is_new, GameTeam.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_team_home)

  let(:valid_model) { FactoryGirl.build(:game_team_home) }

  describe 'associations' do
    it { should belong_to(:game) }
    it { should belong_to(:master) }
    it { should have_many(:members) }
    it { should have_many(:goals) }
    it { should have_many(:fouls) }
    it { should have_many(:changes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:team_id) }
    it { should ensure_inclusion_of(:home_or_away).in_range(Constants.home_or_away.values)}
    # うまく動かない
    # it { should validate_uniqueness_of(:game_id).scoped_to(:team_id) }
  end

  describe 'game_id' do
    game_ids = { nil: nil }
    it_behaves_like :to_invalid_after_attr_change , 'game_id', game_ids do
      let(:target_model) { valid_model }
    end
  end

  describe 'team_id' do
    team_ids = { nil: nil }
    it_behaves_like :to_invalid_after_attr_change , 'team_id', team_ids do
      let(:target_model) { valid_model }
    end
  end

  describe 'home_or_away' do
    invalids = { nil: nil, not_include: (Constants.home_or_away.values.max + 1) }
    it_behaves_like :to_invalid_after_attr_change , 'home_or_away', invalids do
      let(:target_model) { valid_model }
    end

    it_behaves_like :not_invalid_after_attr_change , 'home_or_away', Constants.home_or_away.values do
      let(:target_model) { valid_model }
    end
  end

  describe 'players' do
    context 'when set 10 players' do
      subject {
        team = FactoryGirl.create(:game_team_home)
        fields = { game_team_id: team.id }
        players = FactoryGirl.create_list(:game_member_player, 10, fields)
        team.reload
        team
      }

      it { should have(10).players }
    end
  end

  describe 'managers' do
    context 'when set 10 managers' do
      subject {
        team = FactoryGirl.create(:game_team_home)
        fields = { game_team_id: team.id }
        managers = FactoryGirl.create_list(:game_member_manager, 10, fields)
        team.reload
        team
      }
      it { should have(10).managers }
    end
  end

  context 'when save' do
    subject { FactoryGirl.create(:game_team_home) }
    its(:name) { should_not be_blank}
  end

  context 'when set exist game_id and team_id' do
    subject {
      valid_model.save
      FactoryGirl.build(:game_team_base, { game_id: valid_model.game_id, team_id: valid_model.team_id})
    }
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  context 'when set 2 home teams' do
    subject {
      home = FactoryGirl.create(:game_team_home)
      GameTeam.new({
        game_id: home.game_id,
        team_id: FactoryGirl.create(:team_base).id,
        home_or_away: Constants.home_or_away[:home]})
    }
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  context 'when set 2 away teams' do
    subject {
      home = FactoryGirl.create(:game_team_away)
      GameTeam.new({
        game_id: home.game_id,
        team_id: FactoryGirl.create(:team_base).id,
        home_or_away: Constants.home_or_away[:away]})
    }
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  describe 'fouls' do
    it
  end

  describe 'goals' do
    it
  end

  describe 'changes' do
    it
  end

  describe 'out_of_bench_players' do
    it
  end

  describe 'starting_players' do
    it
  end

  describe 'reserve_players' do
    it
  end

  describe 'can_add_starting_player?' do
    it
  end

  describe 'can_add_reserve_player?' do
    it
  end
end
