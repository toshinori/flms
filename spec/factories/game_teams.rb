# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_team do
    team_id 1
    home_or_away 1
    name "MyString"
  end
end
