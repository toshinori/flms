require "spec_helper"

describe TeamsController do
  let!(:id) { "1" }

  describe 'routing' do
    it { get("/teams").should route_to(controller: "teams", action: "index") }
    it { get("/teams/new").should route_to(controller: "teams", action: "new") }
    it { get("/teams/#{id}/edit").should route_to(controller: "teams", action: "edit", id: id) }
    it { post("/teams").should route_to(controller: "teams", action: "create") }
    it { put("/teams/#{id}").should route_to(controller: "teams", action: "update", id: id) }
    it { delete("/teams/#{id}").should route_to(controller: "teams", action: "destroy", id: id) }
  end


  # pending 'not yet designed.'
  # describe "routing" do

    # it "routes to #index" do
      # get("/teams").should route_to("teams#index")
    # end

    # it "routes to #new" do
      # get("/teams/new").should route_to("teams#new")
    # end

    # it "routes to #show" do
      # get("/teams/1").should route_to("teams#show", :id => "1")
    # end

    # it "routes to #edit" do
      # get("/teams/1/edit").should route_to("teams#edit", :id => "1")
    # end

    # it "routes to #create" do
      # post("/teams").should route_to("teams#create")
    # end

    # it "routes to #update" do
      # put("/teams/1").should route_to("teams#update", :id => "1")
    # end

    # it "routes to #destroy" do
      # delete("/teams/1").should route_to("teams#destroy", :id => "1")
    # end

  # end
end
