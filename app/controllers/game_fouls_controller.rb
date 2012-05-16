class GameFoulsController < ApplicationController

  def new

    @game_foul = GameFoul.new
    @game_team_id = params[:game_team_id]
    @players = GameTeam.find(@game_team_id).players

    respond_to do |format|
      format.js
    end
  end

  def create
    @game_team_id = params[:game_team_id]
    @game_foul = GameFoul.new(params[:game_foul])
    respond_to do |format|
      if @game_foul.save
        @game_foul.reload
        @game_team = GameTeam.find(@game_team_id)
        format.js
      else
        @players = GameTeam.find(@game_team_id).players
        format.js {render action: :new}
      end
    end
  end


  def destroy
    @game_foul = GameFoul.includes(:player).find(params[:id])
    @game_team = @game_foul.player.team
    @game_foul.destroy
    respond_to do |format|
      format.js
    end
  end
end
