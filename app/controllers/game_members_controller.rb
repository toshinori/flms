class GameMembersController < ApplicationController

  def new
    @game_team_id = params[:game_team_id]
    @starting_status = params[:starting_status]

    @game_team = GameTeam.find(@game_team_id)

    @game_member = GameMember.new
    @game_member.game_team_id = @game_team_id
    @game_member.starting_status = @starting_status

    @players = @game_team.out_of_bench_players
    @positions = Position.all

    respond_to do |format|
      format.js
    end
  end

  def create
    @game_member = GameMember.new(params[:game_member])
    @game_team_id = @game_member.game_team_id
    @game_team = GameTeam.find(@game_team_id)
    respond_to do |format|
      if @game_member.save
        @starting_status = @game_member.starting_status
        format.js
      else
        @players = @game_team.out_of_bench_players
        @positions = Position.all
        format.js { render action: 'new' }
      end
    end
  end

  def destroy
    @game_member = GameMember.find(params[:id])
    @game_team = GameTeam.find(@game_member.game_team_id)
    @starting_status = @game_member.starting_status
    @game_member.destroy
    respond_to do |format|
      format.js
    end
  end

end
