# -*- coding: utf-8 -*-
require 'spec_helper'
require 'shared_examples.rb'

describe Member do

  let(:valid_model) { FactoryGirl.build(:member_base, set_player_number: true) }
  let(:created_model) { FactoryGirl.create(:member_base, set_player_number: true) }

  context 'when new' do
    it { should be_a_new(Member) }
    it { should_not be_nil }

    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  describe 'associations' do
    it { should have_one(:team).through(:team_member) }
    it { should belong_to(:position) }
  end

  describe 'valid_model' do
    subject { valid_model }
    its(:valid?) { should be_true }
    its(:save) { should_not be_false }
    it_behaves_like :can_find_by_id, subject
  end

  context 'after save' do
    it { ->{ created_model }.should change(Member, :count).by(1) }
  end

  context 'after destroy' do
    let!(:target) { FactoryGirl.create(:player) }
    it {->{ target.destroy }.should change(Member, :count).by(-1) }
  end

  context 'after delete' do
    let!(:target) { FactoryGirl.create(:player) }
    it {->{ target.delete }.should change(Member, :count).by(-1) }
  end

  #TODO validationの検証を専用のマッチャを使うようにする
  #TODO 正常値も確認するようにする
  describe 'first_name' do
    names = { empty: '', length_over: 'あいうえおあいうえおあ' }
    it_behaves_like :to_invalid_after_attr_change , 'first_name', names do
      let(:target_model) { valid_model }
    end
  end

  describe 'last_name' do
    names = { empty: '', length_over: 'あいうえおあいうえおあ' }
    it_behaves_like :to_invalid_after_attr_change , 'last_name', names do
      let(:target_model) { valid_model }
    end
  end

  describe 'player_number' do
    context 'when set nil' do
      subject { FactoryGirl.build(:member_base, set_player_number: false) }
      its(:player_number) { should be_nil }
      its(:valid?) { should be_true }
      its(:save) { should_not be_false }
    end

    numbers = { include_not_number: '123AB', length_short: '1234', length_over: '12345678901' }
    it_behaves_like :to_invalid_after_attr_change , 'player_number', numbers do
      let(:target_model) { valid_model }
    end

    valid_numbers = ['0123456789', '9876543210']
    it_behaves_like :not_invalid_after_attr_change , 'player_number', valid_numbers do
      let(:target_model) { valid_model }
    end

    context 'when set exists player number' do
      subject {
        exists = FactoryGirl.create(:player, set_player_number: true)
        FactoryGirl.build(:player, { player_number: exists.player_number })
      }
      its(:valid?) { should_not be_true }
      its(:save) { should_not be_true }
    end

    context 'when set destroied player number' do
      subject {
        exists = FactoryGirl.create(:player, set_player_number: true)
        player_number = exists.player_number
        exists.destroy
        FactoryGirl.build(:player, { player_number: player_number})
      }
      its(:valid?) { should_not be_true }
      its(:save) { should_not be_true }
    end
  end

  describe 'member_type' do
    invalids = { nil: nil, not_include: (Member::MemberTypes.max{ |x, y| x[1] <=> y[1] }[1] + 1) }
    it_behaves_like :to_invalid_after_attr_change , 'member_type', invalids do
      let(:target_model) { valid_model }
    end

    it_behaves_like :not_invalid_after_attr_change , 'member_type', Member::MemberTypes.values do
      let(:target_model) { valid_model }
    end

    context 'when set player' do
      subject { FactoryGirl.create(:player) }
      its(:player?) { should be_true }
      its(:manager?) { should_not be_true }
    end

    context 'when set manager' do
      subject { FactoryGirl.create(:manager) }
      its(:player?) { should_not be_true }
      its(:manager?) { should be_true }
    end
  end

  describe 'uniform_number' do
    before (:each) {
      @range = Member::UniformNumberRange
    }

    check_numbers = {
      not_number: 'aaa',
      lower_min:  Member::UniformNumberRange.first - 1,
      over_max:  Member::UniformNumberRange.last + 1
    }

    it_behaves_like :to_invalid_after_attr_change , 'uniform_number', check_numbers do
      let(:target_model) { valid_model }
    end

    valid_numbers = [nil, Member::UniformNumberRange.first, Member::UniformNumberRange.last]
    it_behaves_like :not_invalid_after_attr_change , 'uniform_number', valid_numbers do
      let(:target_model) { valid_model }
    end
  end

end
