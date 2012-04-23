require 'spec_helper'
require 'shared_examples'

describe GameMember do
  it_behaves_like :when_model_is_new, GameMember.new

  describe 'associations' do
    it { should belong_to(:team) }
    it { should belong_to(:member) }
  end

  describe 'validations' do
    it { should validate_presence_of(:game_team_id) }
    it { should validate_presence_of(:member_id) }
    it { should ensure_inclusion_of(:starting_status).in_range(GameMember::StatingStatuses.values) }
  end

  context 'after save' do
    subject { FactoryGirl.create(:game_member_base, valid: true) }
    its(:first_name) { should_not be_blank }
    its(:last_name) { should_not be_blank }
  end

   # describe 'starting_status' do
    # invalids = { nil: nil, not_include: (GameMember::StartingStatus.max{ |x, y| x[1] <=> y[1] }[1] + 1) }
    # it_behaves_like :to_invalid_after_attr_change , 'starting_status', invalids do
      # let(:target_model) { valid_model }
    # end
  # end

end
