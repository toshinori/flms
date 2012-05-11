# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
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
end
