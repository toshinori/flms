require 'spec_helper'

describe Position do
  describe 'records' do
    it { Position.all.should have_exactly(Position::Positions.size).records }
    it { Position.all.collect {|p| p.name}.should ==  Position::Positions }
  end

  describe 'associations' do
    it { should have_many(:players) }
  end

end


