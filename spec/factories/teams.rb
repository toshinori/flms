# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # Teamテーブル
  factory :team_base, class: Team do
    ignore do
      player_count 0
      manager_count 0
    end

    name { "FC:#{Faker::Japanese::Name.first_name[0..9]}" }
    created_at DateTime.now
    updated_at DateTime.now

    after(:create) do |team, evaluator|
      # managerを追加
      if evaluator.manager_count > 0
        managers = FactoryGirl.create_list(:manager, evaluator.manager_count)
        managers.each do |m|
          FactoryGirl.create(:team_member, { team_id: team.id, member_id: m.id })
        end
      end

      # playerを追加
      if evaluator.player_count > 0
        players = FactoryGirl.create_list(:player, evaluator.player_count, set_player_number: true)
        players.each do |p|
          FactoryGirl.create(:team_member, { team_id: team.id, member_id: p.id })
        end
      end

    end
  end
end
