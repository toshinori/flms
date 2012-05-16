FactoryGirl.define do
  factory :game_foul_base, class: GameFoul do
    game_member_id {FactoryGirl.create(:game_member_player).id}
    occurrence_time {FactoryGirl.generate(:occurrence_time)}

    trait :type_caution do
      foul_id { Foul.find_by_symbol(
        Constants.fouls.map{|f| f.symbolize_keys }.detect{ |f| f[:foul_type] == Constants.foul_type[:caution] }[:symbol]).id }
    end
    trait :type_dismissal do
      foul_id { Foul.find_by_symbol(
        Constants.fouls.map{|f| f.symbolize_keys }.detect{ |f| f[:foul_type] == Constants.foul_type[:dismissal] }[:symbol]).id }
    end

    factory :game_foul_caution, traits: [:type_caution]
    factory :game_foul_dismissal, traits: [:type_dismissal]
  end
end
