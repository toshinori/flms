# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_foul do
    game_member_id 1
    occurrence_time 1
    foul_id 1
  end
end
