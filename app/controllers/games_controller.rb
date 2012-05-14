class GamesController < ApplicationController

  # GET /games/1/result/edit
  def edit_result
    @game = Game.find(params[:id])

    @home_team = @game.home_team
    @away_team = @game.away_team

  end

  def show_result
  end

  def update_result
  end
end
