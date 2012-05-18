class GameGoalsController < ApplicationController
  def new
    @game_goal = GameGoal.new
    @game_team_id = params[:game_team_id]
    @players = GameTeam.find(@game_team_id).players

    respond_to do |f|
      f.js
    end
  end

  def create
    @game_team_id = params[:game_team_id]
    @game_goal = GameGoal.new(params[:game_goal])

    respond_to do |f|
      if @game_goal.save
        @game_team = GameTeam.find(@game_team_id)
        f.js
      else
        @players = GameMember.find_all_by_game_team_id(@game_team_id)
        f.js { render action: :new }
      end
    end
  end

  def destroy
    @game_goal = GameGoal.includes(:player).find(params[:id])
    @game_team = @game_goal.player.team
    @game_goal.destroy
    respond_to do |format|
      format.js
    end
  end
end
