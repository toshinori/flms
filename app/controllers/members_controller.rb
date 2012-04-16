class MembersController < ApplicationController

  # GET /teams
  # GET /teams.json
  def index
    @members = Member.all
    respond_to do |format|
      format.html
    end
  end

end
