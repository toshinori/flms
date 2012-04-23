class GameTeam < ActiveRecord::Base
  HomeOrAway = { none: 0, home: 1, away: 2 }.freeze

  belongs_to :game

  belongs_to :team

  has_many :members,
    class_name: GameMember

  validates :game_id,
    presence: true,
    uniqueness: { scope: :team_id }

  validates :team_id,
    presence: true

  validates :home_or_away,
    inclusion: { in: (HomeOrAway.values) }

  before_save do |r|
    r.name = r.team.name
  end

end
