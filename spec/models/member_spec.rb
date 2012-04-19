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

  describe 'association' do
    it { should have_one(:team).through(:team_member) }
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

  describe '#first_name' do
    names = { empty: '', length_over: 'あいうえおあいうえおあ' }
    it_behaves_like :to_invalid_after_attr_change , 'first_name', names do
      let(:target_model) { valid_model }
    end
  end

  describe '#last_name' do
    names = { empty: '', length_over: 'あいうえおあいうえおあ' }
    it_behaves_like :to_invalid_after_attr_change , 'last_name', names do
      let(:target_model) { valid_model }
    end
  end

  describe '#player_number' do
    context 'when set nil' do
      subject { FactoryGirl.build(:member_base, set_player_number: false) }
      its(:player_number) { should be_nil }
      its(:valid?) { should be_true }
      its(:save) { should_not be_false }
    end

    numbers = { include_not_number: '123AB', length_short: '1234', length_over: '123456' }
    it_behaves_like :to_invalid_after_attr_change , 'player_number', numbers do
      let(:target_model) { valid_model }
    end
  end

  describe '#member_type' do
    invalids = { nil: nil, not_include: (Member::MemberTypes.max{ |x, y| x[1] <=> y[1] }[1] + 1) }
    it_behaves_like :to_invalid_after_attr_change , 'member_type', invalids do
      let(:target_model) { valid_model }
    end
  end

end
