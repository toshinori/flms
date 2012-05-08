require 'faker/japanese'

#TODO FactoryGirlのファイルをモデルごとに分割する
FactoryGirl.define do

  # Memberテーブル
  factory :member_base, class: Member do

    ignore do
      set_player_number false
      set_uniform_number false
    end

    first_name { Faker::Japanese::Name.first_name[0..9] }
    last_name { Faker::Japanese::Name.last_name[0..9] }
    player_number { FactoryGirl.generate(:player_number) if set_player_number }
    uniform_number { FactoryGirl.generate(:uniform_number) if set_uniform_number }

    member_type 0
    created_at DateTime.now
    updated_at DateTime.now

    trait :type_player do
      member_type Constants.member_type[:player]
    end

    trait :type_manager do
      member_type Constants.member_type[:manager]
    end

    # 選手
    factory :player, traits: [:type_player]
    # 指導者
    factory :manager, traits: [:type_manager]
  end

  # 選手管理番号を適当に作る
  sequence :player_number do
    sprintf("%010d", (rand(9999999998) + 1) )
  end

  # 背番号を適当に作る
  sequence :uniform_number do
    rand(99)
  end

  # TeamMemberテーブル
  factory :team_member do
    team_id 0
    member_id 0
  end

  # Teamテーブル
  factory :team_base, class: Team do
    ignore do
      player_count 0
      manager_count 0
    end

    name { "FC:#{Faker::Japanese::Name.first_name[0..9]}" }
    created_at DateTime.now
    updated_at DateTime.now

    after_create do |team, evaluator|
      # managerを追加
      if evaluator.manager_count > 0
        managers = FactoryGirl.create_list(:manager, evaluator.manager_count)
        managers.each do |m|
          FactoryGirl.create(:team_member, { team_id: team.id, member_id: m.id })
        end
      end

      # playerを追加
      if evaluator.player_count > 0
        players = FactoryGirl.create_list(:player, evaluator.player_count, set_player_number: true)
        players.each do |p|
          FactoryGirl.create(:team_member, { team_id: team.id, member_id: p.id })
        end
      end

    end
  end

  # Gameモデル
  factory :game_base, class: Game do
    ignore do
      create_teams false
    end

    the_date { Time.now }
    start_time nil
    end_time nil

    after_create do |g, evalator|
      if evalator.create_teams
        home = FactoryGirl.create(:team_base)
        away = FactoryGirl.create(:team_base)
        FactoryGirl.create(:game_team_base,
                           { game_id: g.id, team_id: home.id, home_or_away: GameTeam.home_or_away[:home] })
        FactoryGirl.create(:game_team_base,
                           { game_id: g.id, team_id: away.id, home_or_away: GameTeam.home_or_away[:away] })
      end
    end
  end

  # GameTeamモデル
  factory :game_team_base, class: GameTeam do
    game_id nil
    team_id nil
    home_or_away GameTeam.home_or_away[:none]
    created_at Time.now

    trait :home_team do
      game_id { FactoryGirl.create(:game_base).id }
      team_id { FactoryGirl.create(:team_base).id }
      home_or_away GameTeam.home_or_away[:home]
    end

    trait :away_team do
      game_id { FactoryGirl.create(:game_base).id }
      team_id { FactoryGirl.create(:team_base).id }
      home_or_away GameTeam.home_or_away[:away]
    end

    trait :home_team_not_game_id do
      team_id { FactoryGirl.create(:team_base).id }
      home_or_away GameTeam.home_or_away[:home]
    end

    trait :away_team_not_game_id do
      team_id { FactoryGirl.create(:team_base).id }
      home_or_away GameTeam.home_or_away[:home]
    end

    factory :game_team_home, traits: [:home_team]
    factory :game_team_home_no_game_id, traits: [:home_team_not_game_id]

    factory :game_team_away, traits: [:away_team]
    factory :game_team_away_no_game_id, traits: [:away_team_not_game_id]
  end

  factory :game_member_base, class: GameMember do
    game_team_id { FactoryGirl.create(:game_team_home).id }

    trait :game_member_player_type do
      member_id { FactoryGirl.create(:player).id }
    end

    trait :game_member_manager_type do
      member_id { FactoryGirl.create(:manager).id }
    end

    starting_status 0

    factory :game_member_player, traits: [:game_member_player_type]
    factory :game_member_manager, traits: [:game_member_manager_type]
  end


  # 発生時間
  sequence :occurrence_time do
    rand(150)
  end

  factory :game_foul_base, class: GameFoul do
    game_member_id {FactoryGirl.create(:game_member_player).id}
    occurrence_time {FactoryGirl.generate(:occurrence_time)}

    trait :type_caution do
      foul_id { Foul.find_by_symbol(
        Constants.fouls.map{|f| f.symbolize_keys }.detect{ |f| f[:foul_type] == Constants.foul_type[:caution] }[:symbol]).id }
    end
    trait :type_dismissal do
      foul_id { Foul.find_by_symbol(
        Constants.fouls.map{|f| f.symbolize_keys }.detect{ |f| f[:foul_type] == Constants.foul_type[:dismissal] }[:symbol]).id }
    end

    factory :game_foul_caution, traits: [:type_caution]
    factory :game_foul_dismissal, traits: [:type_dismissal]
  end

  factory :game_goal_base, class: GameGoal do
    game_member_id {FactoryGirl.create(:game_member_player).id}
    occurrence_time {FactoryGirl.generate(:occurrence_time)}
  end

  factory :game_can_start, class: Game do
    the_date { Date.today }
    start_time nil
    end_time nil

    after_create do |g, evalator|
      players_count = 20
      (GameFoul.home_or_away.values - [GameFoul.home_or_away[:none]]).each do |ha|
        players = FactoryGirl.create_list(:player,
                                          players_count,
                                          set_player_number: true,
                                          set_uniform_number: false
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
            starting = GameMember::StartingStatuses[:reserve]
            if GameMember.find_all_by_game_team_id(game_team.id).count < starting_member_count
              starting = GameMember::StartingStatuses[:starting]
            end

            FactoryGirl.create(:game_member_player,
                               { game_team_id: game_team.id, member_id: p.id, starting_status: starting })
          end
        game_team.members.push(game_players)

        game_manager =
            FactoryGirl.create(:game_member_manager, { game_team_id: game_team.id, member_id: manager.id })

        g.teams << game_team
      end
    end
  end

  # ちゃんとした試合のデータ
  # factory :game_can_start , class: Game do
    # home_team_id { FactoryGirl.create(:team_base, manager_count: 1, player_count: 20).id }
    # away_team_id { FactoryGirl.create(:team_base, manager_count: 1, player_count: 20).id }

    # after_create do |game, evaluator|
      # # それぞれのチームのGameMemberを生成
      # team_ids = [ game.home_team_id, game.away_team_id ]
      # team_ids.each do |team_id|
        # # 選手を登録
        # players = Team.find(team_id).players
        # players.each do |p|
          # # スタメンと控えの判定
          # starting = 1
          # starting = 2 if GameMember.find_all_by_game_id_and_team_id(game.id, team_id).count >= 11
          # FactoryGirl.create(:game_member_base,
                             # {game_id: game.id, team_id: team_id, member_id: p.id, starting_status: starting})
        # end
        # # 監督を登録
        # managers = Team.find(team_id).managers
        # managers.each do |m|
          # FactoryGirl.create(:game_member_base, { game_id: game.id, team_id: team_id, member_id: m.id })
        # end
      # end
    # end

  # end

end

