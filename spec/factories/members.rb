# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # Memberテーブル
  factory :member_base, class: Member do

    ignore do
      set_player_number false
      set_uniform_number false
    end

    first_name { Faker::Japanese::Name.first_name[0..9] }
    last_name { Faker::Japanese::Name.last_name[0..9] }
    player_number { FactoryGirl.generate(:player_number) if set_player_number }
    uniform_number { FactoryGirl.generate(:uniform_number) if set_uniform_number }

    member_type 0
    created_at DateTime.now
    updated_at DateTime.now

    trait :type_player do
      member_type Constants.member_type[:player]
    end

    trait :type_manager do
      member_type Constants.member_type[:manager]
    end

    # 選手
    factory :player, traits: [:type_player]
    # 指導者
    factory :manager, traits: [:type_manager]
  end

end
