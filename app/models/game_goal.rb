class GameGoal < ActiveRecord::Base
  default_scope order(:occurrence_time)

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
end
