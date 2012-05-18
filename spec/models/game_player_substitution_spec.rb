require 'spec_helper'
require 'shared_examples.rb'

describe GamePlayerSubstitution do

  it_behaves_like :when_model_is_new, GamePlayerSubstitution.new
  it_behaves_like :when_model_is_valid, FactoryGirl.build(:game_player_substitution_base)

  let(:valid_model) { FactoryGirl.build(:game_player_substitution_base) }

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

    context 'set same player in' do
      subject {
        valid_model.save
        target = GamePlayerSubstitution.new({
          game_member_id: valid_model.game_member_id,
          occurrence_time: valid_model.occurrence_time,
          in_or_out: valid_model.in_or_out
        })
        target
      }
      its(:valid?) { should_not be_true }
      its(:save) { should_not be_true }
    end

    describe 'reserve player' do
      subject {
        valid_model.player.starting_status = Constants.starting_status.reserve
        valid_model
      }
      it { should ensure_inclusion_of(:in_or_out).in_range(Constants.in_or_out.values) }
    end

    context 'when starting player in' do
      subject {
        player = FactoryGirl.create(:game_member_player)
        player.starting_status = Constants.starting_status.starting
        valid_model.game_member_id = player.id
        valid_model.in_or_out = Constants.in_or_out.in
        valid_model
      }
      its(:valid?) { should_not be_true }
      its(:save) { should_not be_true }
    end

    context 'when player in after out' do
      subject {
        out = FactoryGirl.build(:game_player_substitution_base,
                                [starting_status: Constants.starting_status.starting])
        out.occurrence_time = 10
        out.in_or_out = Constants.in_or_out.out
        out.save

        target = GamePlayerSubstitution.new
        target.game_member_id = out.game_member_id
        target.occurrence_time = (out.occurrence_time + 1)
        target.in_or_out = Constants.in_or_out.in
        target
      }

      # its(:valid?) { should_not be_true }
      # its(:save) { should_not be_value }
      it
    end

  end
end
