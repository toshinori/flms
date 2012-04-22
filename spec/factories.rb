require 'faker/japanese'

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
      # member_type Member::MemberType[:player]
      member_type 1
    end

    trait :type_manager do
      # member_type Member::MemberType[:manager]
      member_type 2
    end

    # 選手
    factory :player, traits: [:type_player]
    # 指導者
    factory :manager, traits: [:type_manager]
  end

  # 選手管理番号を適当に作る
  sequence :player_number do
    sprintf("%05d", (rand(99998) + 1) )
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
      valid false
    end
    home_team_id { FactoryGirl.create(:team_base).id if valid }
    away_team_id { FactoryGirl.create(:team_base).id if valid }
  end

  # GameMemberモデル
  factory :game_member_base, class: GameMember do
    game_id nil
    team_id nil
    member_id nil
    starting_status 0
  end

  # ちゃんとした試合のデータ
  factory :game_can_start , class: Game do
    home_team_id { FactoryGirl.create(:team_base, manager_count: 1, player_count: 20).id }
    away_team_id { FactoryGirl.create(:team_base, manager_count: 1, player_count: 20).id }

    after_create do |game, evaluator|
      # それぞれのチームのGameMemberを生成
      team_ids = [ game.home_team_id, game.away_team_id ]
      team_ids.each do |team_id|
        # 選手を登録
        players = Team.find(team_id).players
        players.each do |p|
          # スタメンと控えの判定
          starting = 1
          starting = 2 if GameMember.find_all_by_game_id_and_team_id(game.id, team_id).count >= 11
          FactoryGirl.create(:game_member_base,
                             {game_id: game.id, team_id: team_id, member_id: p.id, starting_status: starting})
        end
        # 監督を登録
        managers = Team.find(team_id).managers
        managers.each do |m|
          FactoryGirl.create(:game_member_base, { game_id: game.id, team_id: team_id, member_id: m.id })
        end
      end
    end

  end

  # GameTeamモデル
  factory :game_team_base, class: GameTeam do
    game_id nil
    team_id nil
    home_or_away 0

    trait :home_team do
      game_id { FactoryGirl.create(:game_base, valid: true).id }
      team_id { FactoryGirl.create(:team_base).id }
      home_or_away 1
    end

    trait :away_team do
      game_id { FactoryGirl.create(:game_base, valid: true).id }
      team_id { FactoryGirl.create(:team_base).id }
      home_or_away 2
    end

    # ホームチーム
    factory :game_team_home, traits: [:home_team]
    # アウェイチーム
    factory :game_team_away, traits: [:away_team]

  end

end

