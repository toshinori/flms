class GameTeam < ActiveRecord::Base

  belongs_to :game

  belongs_to :master,
    class_name: Team,
    foreign_key: :team_id

  has_many :members,
    class_name: GameMember

  has_many :goals,
    class_name: GameGoal,
    through: :game_members

  has_many :fouls,
    class_name: GameFoul,
    through: :game_members

  validates :game_id,
    presence: true,
    uniqueness: { scope: :team_id }

  validates :team_id,
    presence: true

  validates :home_or_away,
    inclusion: { in: (Constants.home_or_away.values) },
    uniqueness: { scope: :game_id}

  before_save do |r|
    r.name = r.master.name
  end

  def players
    self.members.find_all {|m| m.player?}
  end

  def managers
    self.members.find_all {|m| m.manager?}
  end

  def self.home_or_away
    Constants.home_or_away
  end

end
