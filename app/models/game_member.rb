class GameMember < ActiveRecord::Base
  StatingStatuses = { none: 0, stating: 1, reserve: 2 }

  belongs_to :team,
    class_name: GameTeam,
    foreign_key: :game_team_id

  belongs_to :member

  validates :game_team_id,
    presence: true

  validates :member_id,
    presence: true

  validates :starting_status,
    presence: true,
    inclusion: { in: (StatingStatuses.values) }

  before_save do |r|
    r.first_name = r.member.first_name
    r.last_name = r.member.last_name
    r.uniform_number = r.member.uniform_number
  end
  #TODO 試合に関する正規化崩しを検討中
end
