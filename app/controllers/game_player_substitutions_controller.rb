class GamePlayerSubstitutionsController < ApplicationController
  def new
    @game_player_substitution = GamePlayerSubstitution.new
    @game_team_id = params[:game_team_id]
    @players = GameTeam.find(@game_team_id).players

    respond_to do |format|
      format.js
    end
  end

  def create
    @game_team_id = params[:game_team_id]
    @game_player_substitution = GamePlayerSubstitution.new(params[:game_player_substitution])
    respond_to do |format|
      if @game_player_substitution.save
        @game_player_substitution.reload
        @game_team = GameTeam.find(@game_team_id)
        format.js
      else
        @players = GameTeam.find(@game_team_id).players
        format.js {render action: :new}
      end
    end
  end

  def destroy
    @game_player_substitution = GamePlayerSubstitution.includes(:player).find(params[:id])
    @game_team = @game_player_substitution.player.team
    @game_player_substitution.destroy
    respond_to do |format|
      format.js
    end
  end
end
