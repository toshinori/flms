require 'spec_helper'

describe MembersController do

  let(:valid_attributes) { FactoryGirl.attributes_for(:member_base) }
  let(:valid_session) { {} }

  describe 'Mock' do
    context 'Mock Test' do

      it 'aaa' do
        member = Member.new({last_name: 'hoge'})
        Member.any_instance.stub(:save).and_return(false)
        member.save.should be_false
      end

      it 'bb' do
        member = stub(Member)
        member.stub(:last_name).and_return("hoge")
        member.last_name.should  == 'hoge'
        member.should_not be_an_instance_of(Member)
      end

      it 'cc' do
        member = stub_model(Member)
        member.should be_an_instance_of(Member)
      end

      it 'dd' do

        member = stub_model(Member)
        member.stub_chain(:last_name, :to_s)

      end
    end
  end

  describe 'GET index' do
    before (:each) {
      @members = FactoryGirl.create_list(:member_base, 5)
      get :index
    }
    # レスポンスの検証
    its(:response) { should be_success }

    # 描画されたテンプレートの検証
    its(:response) { should render_template(:index) }

    # @membersの検証
    context :members do
      it { assigns(:members).should  == @members }
      it { should assign_to(:members).with(@members) }
    end
  end

  describe "GET new" do
    before (:each) { get :new, {} }
    its(:response) { should be_success }
    its(:response) { should render_template(:new) }
    it { assigns(:member).should be_a_new(Member) }
  end

  describe 'POST create' do

    # 更新可能な値を設定した際の検証
    context 'with valid params' do

      let(:post_valid) { post :create, {:member => valid_attributes}, valid_session }

      # メンバ変数に対する検証
      describe :member do
        # @memberにassignされた値がMemberクラスか検証
        it { post_valid; assigns(:member).should be_a(Member)}
        # @memberにassignされた値がDBに保存されているかを検証
        it { post_valid; assigns(:member).should be_persisted }
      end

      # レコードが1件増えることを検証
      it { ->{ post_valid }.should change(Member, :count).by(1) }

      # リダイレクト先が正しいか検証
      its(:response) { post_valid; should redirect_to(members_url) }
    end

    # 不正な値を設定した際の検証
    context 'with invalid params' do
      let!(:post_empty) {
        # Memberクラスのどのインスタンスのsaveメソッドでも
        # falseが返るようなstubにしている
        Member.any_instance.stub(:save).and_return(false)
        post :create, { member: {} }, valid_session
      }

      context :member  do
        # saveに失敗した後、@memberには新しいMemberクラスのインスタンスが
        # 設定されることを検証
        it { assigns(:member).should be_a_new(Member) }
      end

      its(:response) { should be_success }
      its(:response) { should render_template(:new) }
    end

  end

  describe 'GET edit' do
    let!(:post_edit) {
      member = FactoryGirl.create(:member_base);
      get :edit, { id: member.to_param }, valid_session
      member
    }
    its(:response) { should be_success }
    its(:response) { should render_template(:edit) }
    context :member  do
      it { assigns(:member).should eq(post_edit) }
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      let(:put_update) {
        member = FactoryGirl.create(:member_base)
        put :update, { id: member.to_param, member: valid_attributes }, valid_session
        member
      }

      it 'updates the requested member' do
        member = FactoryGirl.create(:member_base)
        # どんなパラメータが送られてもupdate_attributesメソッドで受け取るということらしい
        # よくわからん
        Member.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, { id: member.to_param, member: { 'these' => 'params' } } , valid_session
      end

      describe :member do
        it { put_update; assigns(:member).should eq(put_update) }
      end

      its(:response) { put_update; should redirect_to(members_url) }
    end

    context 'with invalid params' do

      let!(:put_invalid) {
        member = FactoryGirl.create(:member_base)
        Member.any_instance.stub(:save).and_return(false)
        put :update, { id: member.to_param, member: {} }, valid_session
        member
      }

      describe :member do
        # エラーが発生してもメンバ変数には不正な値は入らないことを検証
        it { assigns(:member).should eq(put_invalid) }
      end

      its(:response) { should be_success }
      its(:response) { should render_template(:edit)}

    end

  end

  describe 'DELETE destroy' do
    let(:delete_destroy) {
      m = FactoryGirl.create(:member_base)
      delete :destroy, { id: m.to_param }, valid_session
    }

    it {
      m = FactoryGirl.create(:member_base)
      ->{ delete :destroy, { id: m.to_param }, valid_session }.should change(Member, :count).by(-1) }

    its(:response) { delete_destroy; should redirect_to(members_url) }
  end

end
