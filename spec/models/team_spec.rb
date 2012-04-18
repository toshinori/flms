# -*- coding: utf-8 -*-
require 'spec_helper'
require 'shared_examples'

describe Team do
  let(:valid_model) { FactoryGirl.build(:team_base) }
  let(:created_model) { FactoryGirl.create(:team_base) }

  context 'when new' do
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  describe 'valid model' do
    subject { valid_model }
    its(:valid?) { should be_true }
    its(:save) { should be_true }
  end

  context 'after save' do
    it { ->{ created_model }.should change(Team, :count).by(1) }
  end

  context 'after delete' do
    let!(:target) { FactoryGirl.create(:team_base) }
    it { ->{ target.delete }.should change(Team, :count).by(-1) }
  end

  context 'after destroy' do
    let!(:target) { FactoryGirl.create(:team_base) }
    it {->{ target.destroy }.should change(Team, :count).by(-1) }
  end

  describe 'association' do
    it { should have_many(:members).through(:team_members) }
  end

  describe 'attributes' do
    test_values = {empty: '', length_over: 'あいうえおあいうえおあいうえおあいうえおあ'}

    it_behaves_like :to_invalid_after_attr_change, 'name', test_values do
      let(:target_model) { valid_model }
    end

  end

  describe 'members attribute' do

    context 'can add new member' do
      subject { created_model }
      let!(:new_member) { FactoryGirl.create(:player) }
      it { ->{ subject.add_member(new_member) }.should change(subject.members, :count).by(1) }
    end

    context 'can remove a member' do
      subject { created_model }
      let!(:new_member) { FactoryGirl.create(:player) }
      let!(:member_add) { subject.add_member(new_member); subject }
      it { ->{ member_add.remove_member(new_member) }.should change(subject.members, :count).by(-1) }
    end

    context 'after destroy' do
      let!(:target) { FactoryGirl.create(:team_base, player_count: 10) }
      let!(:members_count) { target.members.count }
      it {->{ target.destroy }.should change(target.members, :count).from(members_count).to(0)}
    end

  end

  describe 'players method' do
    context 'add 5 players' do
      before do
        @team = FactoryGirl.create(:team_base)
        players = FactoryGirl.create_list(:player, 5)
        players.each { |p| @team.add_member(p) }
      end

      subject { @team }
      let!(:players_count) { subject.members.find_all_by_member_type(Member::MemberTypes[:player]).count }
      its('players.count') { should == players_count}
    end
  end

  describe 'managers method' do
    context 'add 5 managers' do
      before do
        @team = FactoryGirl.create(:team_base)
        players = FactoryGirl.create_list(:manager, 5)
        players.each { |p| @team.add_member(p) }
      end

      subject { @team }
      let!(:managers_count) { subject.members.find_all_by_member_type(Member::MemberTypes[:manager]).count }
      its('managers.count') { should == managers_count }
    end
  end
end
