# -*- coding: utf-8 -*-
require 'spec_helper'
require 'shared_examples'

describe Team do
  let(:valid_model) { FactoryGirl.build(:team_base) }
  let(:created_model) { FactoryGirl.create(:team_base) }

  it_behaves_like :when_model_is_new, Team.new
  it_behaves_like :when_model_is_valid, FactoryGirl.create(:team_base)

  context 'after save' do
    it { ->{ created_model }.should change(Team, :count).by(1) }
  end

  context 'after delete' do
    let!(:target) { FactoryGirl.create(:team_base) }
    subject { target }
    it { ->{ target.delete }.should change(Team, :count).by(-1) }
  end

  context 'after destroy' do
    subject {  FactoryGirl.create(:team_base, player_count: 10) }
    before { subject.destroy }
    it { Team.find_all_by_id(subject.id).count.should == 0 }
    describe TeamMember do
      it { TeamMember.find_all_by_team_id(subject.id).count.should == 0}
    end
  end

  describe 'association' do
    it { should have_many(:members).through(:team_members) }
    it { should have_many(:players) }
    it { should have_many(:managers) }
    it { should have_many(:home_games) }
    it { should have_many(:away_games) }
    it { should have_many(:game_progresses) }
  end

  describe 'attributes' do
    test_values = {empty: '', length_over: 'あいうえおあいうえおあいうえおあいうえおあ'}
    it_behaves_like :to_invalid_after_attr_change, 'name', test_values do
      let(:target_model) { valid_model }
    end
  end

  describe 'members' do

    context 'when add new member' do
      subject { created_model }
      let!(:new_member) { FactoryGirl.create(:player) }
      it { ->{ subject.members << new_member }.should change(subject.members, :count).by(1) }
    end

    context 'when member a member' do
      subject { created_model }
      let!(:new_member) { FactoryGirl.create(:player) }
      let!(:member_add) { subject.members << new_member; subject }
      it { ->{ member_add.members.delete(new_member) }.should change(subject.members, :count).by(-1) }
    end

    context 'when after destroy' do
      let!(:target) { FactoryGirl.create(:team_base, player_count: 10) }
      let!(:members_count) { target.members.count }
      it {->{ target.destroy }.should change(target.members, :count).from(members_count).to(0)}
    end

  end

  describe 'players' do
    context 'when add 5 players' do
      before do
        @team = FactoryGirl.create(:team_base)
        players = FactoryGirl.create_list(:player, 5)
        players.each { |p| @team.members << p }
      end

      subject { @team }
      let!(:players_count) { subject.members.find_all_by_member_type(Constants.member_types[:player]).count }
      its('players.count') { should == players_count}
      it { subject.players.all {|p| p.member_type  == Constants.member_types[:player]}.should be_true }
    end
  end

  describe 'managers' do
    context 'when add 5 managers' do
      before do
        @team = FactoryGirl.create(:team_base)
        players = FactoryGirl.create_list(:manager, 5)
        players.each { |p| @team.members << p }
      end

      subject { @team }
      let!(:managers_count) { subject.members.find_all_by_member_type(Constants.member_types[:manager]).count }
      its('managers.count') { should == managers_count }
      it { subject.managers.all {|p| p.member_type  == Constants.member_types[:manager]}.should be_true }
    end
  end

  describe 'home_games' do
    pending 'have not desigined yat.'
  end

  describe 'away_games' do
    pending 'have not desigined yat.'
  end

  describe 'games' do
    pending 'have not desigined yat.'
  end

  describe 'game_progresses' do
    pending 'have not desigined yat.'
  end
end

