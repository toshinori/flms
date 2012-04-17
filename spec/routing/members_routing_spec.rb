describe MembersController do

  describe 'routing' do
    let!(:id) { "1" }

    describe 'routing' do
      it { get("/members").should route_to(controller: "members", action: "index") }
      it { get("/members/new").should route_to(controller: "members", action: "new") }
      it { get("/members/#{id}/edit").should route_to(controller: "members", action: "edit", id: id) }
      it { post("/members").should route_to(controller: "members", action: "create") }
      it { put("/members/#{id}").should route_to(controller: "members", action: "update", id: id) }
      it { delete("/members/#{id}").should route_to(controller: "members", action: "destroy", id: id) }
    end
  end

end
