
FactoryGirl.define do

  factory :game_player_substitution_base, class: GamePlayerSubstitution do
    ignore do
      starting_status Constants.starting_status.reserve
    end

    game_member_id { FactoryGirl.create(:game_member_player, {starting_status: starting_status}).id }
    occurrence_time {FactoryGirl.generate(:occurrence_time)}
    in_or_out { Constants.in_or_out.in }
  end
end
