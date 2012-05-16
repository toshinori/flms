FactoryGirl.define do
  factory :game_goal_base, class: GameGoal do
    game_member_id {FactoryGirl.create(:game_member_player).id}
    occurrence_time {FactoryGirl.generate(:occurrence_time)}
  end
end
