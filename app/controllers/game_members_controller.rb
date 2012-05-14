class GameMembersController < ApplicationController
  def index
  end

  def new
    @game_member = GameMember.new
    @game_team_id = params[:game_team_id]
    @game_team = GameTeam.find(@game_team_id)
    @game_member.game_team_id = params[:game_team_id]

    unless @game_team.blank? and @game_team.players.blank?
      @players = @game_team.master.players - @game_team.players
    end

    @positions = Position.all

    respond_to do |format|
      format.js
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
