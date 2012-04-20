require 'faker/japanese'

FactoryGirl.define do

  # Memberテーブル
  factory :member_base, class: Member do

    ignore do
      set_player_number false
    end

    first_name { Faker::Japanese::Name.first_name[0..9] }
    last_name { Faker::Japanese::Name.last_name[0..9] }
    player_number { FactoryGirl.generate(:player_number) if set_player_number }
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

  sequence :player_number do
    sprintf("%05d", (rand(99998) + 1) )
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
end

