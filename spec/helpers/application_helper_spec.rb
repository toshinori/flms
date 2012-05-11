require 'spec_helper'

describe ApplicationHelper do
  extend(ApplicationHelper)

  describe 'translate_constant' do
    it
  end

  describe 'member_type_for_display' do
    Constants.member_type.each do |k, v|
      it "when set #{v} should return #{translate_constant(:member_type, k)}" do
        member_type_for_display(v).should eql(translate_constant(:member_type, k))
      end
    end
  end

  describe 'member_type_for_select' do
    Constants.member_type.each do |k, v|
      subject { member_type_for_select }
      it { should include([translate_constant(:member_type, k), v]) }
    end
  end

  describe 'foul_for_select' do
    context 'when set nil' do
      subject { foul_for_select(nil) }
      Foul.all.each do |foul|
        it do
          description = translate_constant(:foul, foul.symbol)
          should include([ "#{foul.symbol}#{Constants.select_separator}#{description}",  foul.id ])
        end
      end
      context 'when set none' do
        subject { foul_for_select(Constants.foul_type.none) }
        its(:blank?) { should be_true }
      end

      context 'when set caution' do
        subject { foul_for_select(Constants.foul_type.caution) }
        Foul.find_all_by_foul_type(Constants.foul_type.caution).each do |foul|
          it do
            description = translate_constant(:foul, foul.symbol)
            should include([ "#{foul.symbol}#{Constants.select_separator}#{description}",  foul.id ])
          end
        end
      end

      context 'when set dismissal' do
        subject { foul_for_select(Constants.foul_type.dismissal) }
        Foul.find_all_by_foul_type(Constants.foul_type.dismissal).each do |foul|
          it do
            description = translate_constant(:foul, foul.symbol)
            should include([ "#{foul.symbol}#{Constants.select_separator}#{description}",  foul.id ])
          end
        end
      end
    end


  end

end

