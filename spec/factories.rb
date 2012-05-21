require 'faker/japanese'

FactoryGirl.define do

  # 選手管理番号
  sequence :player_number do
    sprintf("%010d", (rand(9999999998) + 1) )
  end

  # 背番号
  sequence :uniform_number do
    rand(1..99)
  end

  # 発生時間
  sequence :occurrence_time do
    rand(150)
  end

  # ポジション
  sequence :position do
    # Position#idは1から開始
    rand(1..Constants.position.size)
  end

  # 正常な試合データを作成
  factory :game_can_start, class: Game do

    ignore do
      players_count 20
      not_join_players 5
      foul_count 5
      goal_count 3
      substitution_count 3
    end

    the_date { Date.today }
    start_time nil
    end_time nil

    after(:create) do |g, evalator|

      # ホームチームとアウェイチームでデータを作成
      (Constants.home_or_away.values - [Constants.home_or_away[:none]]).each do |ha|
        # 選手を作成
        players = FactoryGirl.create_list(:player,
                                          evalator.players_count,
                                          set_player_number: true,
                                          set_uniform_number: true,
                                          set_position: true
                                         )

        # 監督を作成
        manager = FactoryGirl.create(:manager)

        # チームを作成
        team = FactoryGirl.create(:team_base)

        # 選手と監督をチームに登録
        players.each {|p| team.members << p}
        team.members << manager

        # 試合に参加しない選手を登録
        if evalator.not_join_players > 0
          FactoryGirl.create_list(:player,
                                  evalator.not_join_players,
                                  set_player_number: true,
                                  set_uniform_number: true,
                                  set_position: true
                                 ).each {|p| team.members << p}
        end

        # チームを試合に登録
        game_team = FactoryGirl.create(:game_team_base,
                                       { game_id: g.id, team_id: team.id, home_or_away: ha }
                                      )

        # 試合に出場する選手を登録
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

        # 監督を試合に登録
        game_manager =
            FactoryGirl.create(:game_member_manager, { game_team_id: game_team.id, member_id: manager.id })

      end

      # ファールを作成
      g.reload
      evalator.foul_count.times do
        foul_types = [:game_foul_caution, :game_foul_dismissal]
        foul_player = g.teams.sample.players.sample
        FactoryGirl.create(foul_types.sample, {game_member_id: foul_player.id})
      end

      # ゴールを作成
      evalator.goal_count.times do
        goal_player = g.teams.sample.players.sample
        FactoryGirl.create(:game_goal_base,  {game_member_id: goal_player.id})
      end

      # 選手交代を作成
      evalator.substitution_count.times do

        out_player = g.teams.sample.players.select {|p| p.starting_player? }.sample
        in_player = out_player.team.players.select {|p| p.reserve_player? }.sample
        time = generate(:occurrence_time)
        create(:game_player_substitution_base, {
          game_member_id: out_player.id,
          in_or_out: Constants.in_or_out.out,
          occurrence_time: time
        })

        create(:game_player_substitution_base, {
          game_member_id: in_player.id,
          in_or_out: Constants.in_or_out.in,
          occurrence_time: time
        })
      end

    end
  end

end

