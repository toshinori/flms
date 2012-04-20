class GameMember < ActiveRecord::Base
  StatingStatuses = { none: 0, stating: 1, reserve: 2 }
  belongs_to :game
  belongs_to :team
  belongs_to :member

  validates :game_id,
    presence: true

  validates :team_id,
    presence: true

  validates :member_id,
    presence: true

  validates :starting_status,
    presence: true,
    inclusion: { in: (StatingStatuses.values) }
end
