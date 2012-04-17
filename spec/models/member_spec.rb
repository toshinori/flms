require 'spec_helper'

describe Member do

  shared_examples_for :to_invalid_after_attr_change do |name, test_values|
    test_values.each do |label, value|
      context "set '#{value}'(#{label.to_s})" do
        subject { target_model }
        it { ->{ subject[name] = value}.should change(subject, :invalid?).from(false).to(true)}
        it {
          subject[name] = value
          should have_at_least(1).errors_on(name)
        }
      end
    end
  end

  context 'when new' do
    it { should be_a_new(Member) }
    it { should_not be_nil }

    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

  let(:valid_model) { FactoryGirl.build(:member_base, set_player_number: true) }

  describe 'valid_model' do
    subject { valid_model }
    its(:valid?) { should be_true }
    its(:save) { should_not be_false }
  end

  describe 'player_number attribute' do
    context 'set nil' do
      subject { FactoryGirl.build(:member_base, set_player_number: false) }
      its(:player_number) { should be_nil }
      its(:valid?) { should be_true }
      its(:save) { should_not be_false }
    end

    numbers = { include_not_number: '123AB', length_short: '1234', length_over: '123456' }

    it_behaves_like :to_invalid_after_attr_change , 'player_number', numbers do
      let(:target_model) { valid_model }
    end
  end

end
