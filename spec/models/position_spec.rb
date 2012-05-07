require 'spec_helper'

describe Position do
  describe 'records' do
    it { Position.all.should have_exactly(Constants.positions.size).records }
    it { Position.all.collect {|p| p.name}.should == Constants.positions }
  end

  describe 'associations' do
    it { should have_many(:players) }
  end

end


