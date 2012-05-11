
FactoryGirl.define do

  # factory :game_foul_base, class: GameFoul do
  factory :gaem_player_change_base, class: GamePlayerChange do
    game_member_id { FactoryGirl.create(:game_member_player).id }
    occurrence_time {FactoryGirl.generate(:occurrence_time)}
    in_or_out { Constants.in_or_out.in }
  end
end
