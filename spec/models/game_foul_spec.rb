require 'spec_helper'
require 'shared_examples.rb'

describe GameFoul do
  it_behaves_like :when_model_is_new, GameFoul.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_foul_caution)

  let(:valid_model) { FactoryGirl.build(:game_foul_caution) }

  describe 'associations' do
    it { should belong_to(:player) }
    it { should belong_to(:foul) }
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

  describe 'foul_id' do
    foul_ids = { nil: nil }
    it_behaves_like :to_invalid_after_attr_change , 'foul_id', foul_ids do
      let(:target_model) { valid_model }
    end
  end
end
