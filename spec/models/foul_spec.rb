require 'spec_helper'

describe Foul do

  describe 'records' do
    it { Foul.all.should have_exactly(Foul::FoulSeeds.size).records }
  end

  describe 'associations' do
    pending 'have not desigined.'
  end
end
