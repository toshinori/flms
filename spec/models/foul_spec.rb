require 'spec_helper'
require 'shared_examples.rb'

describe Foul do

  describe 'records' do
    it { Foul.all.should have_exactly(Constants.fouls.size).records }
  end

  describe 'associations' do
    it { should have_many(:game_fouls) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:symbol) }
  end

  describe 'symbol' do

    Constants.fouls.each do |f|
      context "find by #{f['symbol']}" do
        it { ->{ Foul.find_by_symbol(f['symbol']) }.should_not raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when set exists symbol' do
      subject {
        Foul.new(symbol: Constants.fouls[0]['symbol'])
      }
      its(:valid?) { should_not be_true }
      its(:save) { should be_false }
    end

  end

  describe 'caution_ids' do
    before do
      @ids = Foul.caution_ids
    end
    it 'ids are caution foul' do
      @ids.each do |id|
        foul = Foul.find(id)
        foul.foul_type.should == Constants.foul_type.caution
      end
    end
  end

  describe 'dismissal_ids' do
    before do
      @ids = Foul.dismissal_ids
    end
    it 'ids are dismissal foul' do
      @ids.each do |id|
        foul = Foul.find(id)
        foul.foul_type.should == Constants.foul_type.dismissal
      end
    end
  end
end
