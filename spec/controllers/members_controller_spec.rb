require 'spec_helper'

describe MembersController do


  context 'GET index' do
    before (:each) {
      @members = FactoryGirl.create_list(:member_base, 5)
      get :index
    }
    its(:response) { should be_success }
    its(:response) { should render_template('members/index') }
    it { assigns(:members).should  == @members }

  end

end
