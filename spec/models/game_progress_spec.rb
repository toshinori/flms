require 'spec_helper'

describe GameProgress do

  context 'when new' do
    its(:valid?) { should_not be_true }
    its(:save) { should_not be_true }
  end


  describe 'association' do
    it { should belong_to(:game) }
    it { should belong_to(:team) }
    it { should belong_to(:player) }
    # it { should have_many(:member) }
    # it { should belong_to(:member) }
  end

  # describe 'association' do
    # it { should have_many(:progresses) }
  # end

end
