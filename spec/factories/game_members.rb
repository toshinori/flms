# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_member_base, class: GameMember do
    game_team_id { FactoryGirl.create(:game_team_home).id }

    trait :game_member_player_type do
      member_id { FactoryGirl.create(:player).id }
    end

    trait :game_member_manager_type do
      member_id { FactoryGirl.create(:manager).id }
    end

    starting_status Constants.starting_status.starting

    factory :game_member_player, traits: [:game_member_player_type]
    factory :game_member_manager, traits: [:game_member_manager_type]
  end

end
