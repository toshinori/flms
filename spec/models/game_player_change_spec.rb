require 'spec_helper'
require 'shared_examples.rb'

describe GamePlayerChange do

  it_behaves_like :when_model_is_new, GamePlayerChange.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:gaem_player_change_base)

  let(:valid_model) { FactoryGirl.build(:gaem_player_change_base) }

  describe 'associations' do
    it { should belong_to(:player) }
  end

  describe 'game_member_id' do
    game_member_ids = { nil: nil }
    it_behaves_like :to_invalid_after_attr_change , :game_member_id, game_member_ids do
      let(:target_model) { valid_model }
    end
    #TODO 出場選手しか登録できないようにする
  end

  describe 'occurrence_time' do
    occurrence_times = { nil: nil, not_number: 'aa', max_over: Constants.game_time_range.max + 1}
    it_behaves_like :to_invalid_after_attr_change , 'occurrence_time', occurrence_times do
      let(:target_model) { valid_model }
    end

    it_behaves_like :not_invalid_after_attr_change , 'occurrence_time',
      [Constants.game_time_range.min, Constants.game_time_range.max]
    let(:target_model) { valid_model }
  end

  describe 'in_or_out' do
    ids = { nil: nil, not_exists_in_constants: Constants.in_or_out.values.max + 1 }
    it_behaves_like :to_invalid_after_attr_change , :in_or_out , ids do
      let(:target_model) { valid_model }
    end

    it_behaves_like :not_invalid_after_attr_change , :in_or_out , Constants.in_or_out.values
    let(:target_model) { valid_model }

    context 'set same player in' do
      subject {
        valid_model.save
        target = GamePlayerChange.new({
          game_member_id: valid_model.game_member_id,
          occurrence_time: valid_model.occurrence_time,
          in_or_out: valid_model.in_or_out
        })
        target
      }
      its(:valid?) { should_not be_true }
      its(:save) { should_not be_true }
    end

  end
end
