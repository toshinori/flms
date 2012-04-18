require 'spec_helper'

describe TeamMember do

  context 'when new' do
    its(:valid?) { should be_false }
    its(:save) { should be_false }
  end

  describe 'association' do
    it { should belong_to(:team) }
    it { should belong_to(:member) }
  end

  let(:valid_model) {
    team = FactoryGirl.create(:team_base)
    member = FactoryGirl.create(:member_base)
    FactoryGirl.build(:team_member, { team_id: team.id, member_id: member.id })
  }

  context 'can save' do
    subject {
      valid_model
    }
    its(:valid?) { should be_true }
    its(:save) { should_not be_false }
  end

  context 'can not save exist id' do
    subject {
      valid_model.save
      FactoryGirl.build(:team_member, { team_id: valid_model.team_id, member_id: valid_model.member_id })
    }
    its(:valid?) { should_not be_true }
    its(:save) { should be_false }
  end

end
