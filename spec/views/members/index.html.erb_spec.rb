require 'spec_helper'

describe "members/index" do
  before (:each) {
    assign(:members, FactoryGirl.create_list(:member_base, 10))
    render
  }

  describe 'list headers' do
    it 'id rendered' do
      assert_select "thead>tr>th", text: %r(^id$)i
    end
    it 'last name rendered' do
      assert_select "thead>tr>th", text: %r(^Last Name$)i
    end
  end

  it 'render members' do
    assert_select "h1", count: 1
  end

end
