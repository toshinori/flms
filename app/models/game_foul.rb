class GameFoul < ActiveRecord::Base
  belongs_to :player,
    class_name: GameMember,
    foreign_key: :game_member_id

  belongs_to :foul

  validates :game_member_id,
    presence: true

  validates :foul_id,
    presence: true

  validates :occurrence_time,
    allow_blank: false,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: Game::GameTime.first,
      less_than_or_equal_to: Game::GameTime.last
      }
end
