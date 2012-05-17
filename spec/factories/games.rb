# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # Gameモデル
  factory :game_base, class: Game do
    ignore do
      create_teams false
    end

    the_date { Time.now }
    start_time nil
    end_time nil

    after(:create) do |g, evalator|
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
end
