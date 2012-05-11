# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_player_change do
    game_member_id 1
    occurrence_time 1
    in_or_out 1
  end
end
