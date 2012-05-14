require 'faker/japanese'

FactoryGirl.define do

  # 選手管理番号を適当に作る
  sequence :player_number do
    sprintf("%010d", (rand(9999999998) + 1) )
  end

  # 背番号を適当に作る
  sequence :uniform_number do
    rand(1..99)
  end

  # 発生時間
  sequence :occurrence_time do
    rand(150)
  end

  factory :game_can_start, class: Game do
    the_date { Date.today }
    start_time nil
    end_time nil

    after_create do |g, evalator|
      players_count = 20
      (Constants.home_or_away.values - [Constants.home_or_away[:none]]).each do |ha|
        players = FactoryGirl.create_list(:player,
                                          players_count,
                                          set_player_number: true,
                                          set_uniform_number: true
                                         )
        manager = FactoryGirl.create(:manager)
        team = FactoryGirl.create(:team_base)

        players.each {|p| team.members << p}
        team.members << manager

        game_team = FactoryGirl.create(:game_team_base,
                                       { game_id: g.id, team_id: team.id, home_or_away: ha }
                                      )

        starting_member_count = 11
        game_players =
          players.collect do |p|
            starting = Constants.starting_status[:reserve]
            if GameMember.find_all_by_game_team_id(game_team.id).count < starting_member_count
              starting = Constants.starting_status[:starting]
            end

            FactoryGirl.create(:game_member_player,
                               { game_team_id: game_team.id, member_id: p.id, starting_status: starting })
          end
        # game_team.members.push(game_players)

        game_manager =
            FactoryGirl.create(:game_member_manager, { game_team_id: game_team.id, member_id: manager.id })

        # g.teams << game_team
      end
    end
  end


end

