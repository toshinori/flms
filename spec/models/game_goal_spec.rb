require 'spec_helper'
require 'shared_examples.rb'

describe GameGoal do
  it_behaves_like :when_model_is_new, GameGoal.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_goal_base)

  let(:valid_model) { FactoryGirl.build(:game_goal_base) }
  describe 'associations' do
    it { should belong_to(:player) }
  end

  describe 'game_member_id' do
    game_member_ids = { nil: nil }
    it_behaves_like :to_invalid_after_attr_change , 'game_member_id', game_member_ids do
      let(:target_model) { valid_model }
    end
  end

  describe 'occurrence_time' do
    occurrence_times = { nil: nil, not_number: 'aa', max_over: 1000 }
    it_behaves_like :to_invalid_after_attr_change , 'occurrence_time', occurrence_times do
      let(:target_model) { valid_model }
    end

    it_behaves_like :not_invalid_after_attr_change , 'occurrence_time', [0, 999] do
      let(:target_model) { valid_model }
    end
  end

  context 'when save' do
    it { ->{ valid_model.save }.should change(GameGoal, :count).by(1) }
  end

  context 'when destroy' do
    let!(:target) { FactoryGirl.create(:game_goal_base) }
    it { ->{ target.delete }.should change(GameGoal, :count).by(-1) }
  end
end
