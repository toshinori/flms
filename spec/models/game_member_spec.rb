require 'spec_helper'
require 'shared_examples'

describe GameMember do
  it_behaves_like :when_model_is_new, GameMember.new

  context 'assosiation' do
    it { should belong_to(:game) }
    it { should belong_to(:team) }
    it { should belong_to(:member) }
  end

  # describe 'starting_status' do
    # invalids = { nil: nil, not_include: (GameMember::StartingStatus.max{ |x, y| x[1] <=> y[1] }[1] + 1) }
    # it_behaves_like :to_invalid_after_attr_change , 'starting_status', invalids do
      # let(:target_model) { valid_model }
    # end
  # end

end
