require 'faker/japanese'

FactoryGirl.define do

  factory :member_base, class: Member do

    ignore do
      set_player_number false
    end

    first_name { Faker::Japanese::Name.first_name[0..9] }
    last_name { Faker::Japanese::Name.last_name[0..9] }
    player_number { FactoryGirl.generate(:player_number) if set_player_number }

  end

  sequence :player_number do
    sprintf("%05d", (rand(99998) + 1) )
  end

end

