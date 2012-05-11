class GamePlayerChange < ActiveRecord::Base
  belongs_to :player,
    class_name: GameMember,
    foreign_key: :game_member_id

  validates :game_member_id,
    presence: true

  validates :occurrence_time,
    allow_blank: false,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: Constants.game_time_range.min,
      less_than_or_equal_to: Constants.game_time_range.max
      }

  validates :in_or_out,
    allow_blank: false,
    inclusion: { in: (Constants.in_or_out.values) },
    uniqueness: { scope: :game_member_id }
end
