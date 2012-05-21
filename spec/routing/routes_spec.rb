require "spec_helper"

shared_examples_for :game_results_routing do |controller|
  let!(:id) { "1" }

  describe 'routing' do
    it { get("/#{controller}/new").should route_to(controller: controller, action: "new") }
    it { post("/#{controller}").should route_to(controller: controller, action: "create") }
    it { delete("/#{controller}/#{id}").should route_to(controller: controller, action: "destroy", id: id) }
    it { get("/#{controller}/#{id}/edit").should_not route_to(controller: controller, action: "edit", id: id) }
    it { put("/#{controller}/#{id}").should_not route_to(controller: controller, action: "destroy", id: id) }
  end
end

describe GameMembersController do
  it_behaves_like :game_results_routing, GameMember.name.tableize
end

describe GameFoulsController do
  it_behaves_like :game_results_routing, GameFoul.name.tableize
end

describe GameGoalsController do
  it_behaves_like :game_results_routing, GameGoal.name.tableize
end

describe GamePlayerSubstitutionsController do
  it_behaves_like :game_results_routing, GamePlayerSubstitution.name.tableize
end
