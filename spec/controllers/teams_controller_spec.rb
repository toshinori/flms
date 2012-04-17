require 'spec_helper'


describe TeamsController do

  def valid_attributes
    FactoryGirl.build(:team_base)
  end

  def valid_session
    {}
  end

  # describe "GET index" do
    # it "assigns all teams as @teams" do
      # team = Team.create! valid_attributes
      # get :index, {}, valid_session
      # assigns(:teams).should eq([team])
    # end
  # end

  # describe "GET show" do
    # it "assigns the requested team as @team" do
      # team = Team.create! valid_attributes
      # get :show, {:id => team.to_param}, valid_session
      # assigns(:team).should eq(team)
    # end
  # end

  describe "GET new" do
    it "assigns a new team as @team" do
      get :new, {}, valid_session
      assigns(:team).should be_a_new(Team)
    end
  end

  # describe "GET edit" do
    # it "assigns the requested team as @team" do
      # team = Team.create! valid_attributes
      # get :edit, {:id => team.to_param}, valid_session
      # assigns(:team).should eq(team)
    # end
  # end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Team" do
        expect {
          post :create, {:team => valid_attributes}, valid_session
        }.to change(Team, :count).by(1)
      end

      it { ->{ post :create, { team: valid_attributes }, valid_session }.should change(Team, :count).by(1) }
      it "assigns a newly created team as @team" do
        post :create, {:team => valid_attributes}, valid_session
        assigns(:team).should be_a(Team)
        assigns(:team).should be_persisted
      end

      it "redirects to the created team" do
        post :create, {:team => valid_attributes}, valid_session
        response.should redirect_to(teams_url)
      end
    end

    # describe "with invalid params" do
      # it "assigns a newly created but unsaved team as @team" do
        # # Trigger the behavior that occurs when invalid params are submitted
        # Team.any_instance.stub(:save).and_return(false)
        # post :create, {:team => {}}, valid_session
        # assigns(:team).should be_a_new(Team)
      # end

      # it "re-renders the 'new' template" do
        # # Trigger the behavior that occurs when invalid params are submitted
        # Team.any_instance.stub(:save).and_return(false)
        # post :create, {:team => {}}, valid_session
        # response.should render_template("new")
      # end
    # end
  end

  # describe "PUT update" do
    # describe "with valid params" do
      # it "updates the requested team" do
        # team = Team.create! valid_attributes
        # # Assuming there are no other teams in the database, this
        # # specifies that the Team created on the previous line
        # # receives the :update_attributes message with whatever params are
        # # submitted in the request.
        # Team.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        # put :update, {:id => team.to_param, :team => {'these' => 'params'}}, valid_session
      # end

      # it "assigns the requested team as @team" do
        # team = Team.create! valid_attributes
        # put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        # assigns(:team).should eq(team)
      # end

      # it "redirects to the team" do
        # team = Team.create! valid_attributes
        # put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        # response.should redirect_to(team)
      # end
    # end

    # describe "with invalid params" do
      # it "assigns the team as @team" do
        # team = Team.create! valid_attributes
        # # Trigger the behavior that occurs when invalid params are submitted
        # Team.any_instance.stub(:save).and_return(false)
        # put :update, {:id => team.to_param, :team => {}}, valid_session
        # assigns(:team).should eq(team)
      # end

      # it "re-renders the 'edit' template" do
        # team = Team.create! valid_attributes
        # # Trigger the behavior that occurs when invalid params are submitted
        # Team.any_instance.stub(:save).and_return(false)
        # put :update, {:id => team.to_param, :team => {}}, valid_session
        # response.should render_template("edit")
      # end
    # end
  # end

  # describe "DELETE destroy" do
    # it "destroys the requested team" do
      # team = Team.create! valid_attributes
      # expect {
        # delete :destroy, {:id => team.to_param}, valid_session
      # }.to change(Team, :count).by(-1)
    # end

    # it "redirects to the teams list" do
      # team = Team.create! valid_attributes
      # delete :destroy, {:id => team.to_param}, valid_session
      # response.should redirect_to(teams_url)
    # end
  # end

end
