class GameMember < ActiveRecord::Base
  StartingStatuses = { none: 0, starting: 1, reserve: 2 }

  belongs_to :team,
    class_name: GameTeam,
    foreign_key: :game_team_id

  belongs_to :master,
    class_name: Member,
    foreign_key: :member_id

  belongs_to :position

  has_many :fouls,
    class_name: GameFoul,
    order:  :occurrence_time

  has_many :goals,
    class_name: GameGoal,
    order: :occurrence_time

  validates :game_team_id,
    presence: true

  validates :member_id,
    presence: true

  validates :starting_status,
    presence: true,
    inclusion: { in: (StartingStatuses.values) }

  def player?
    self.master.member_type == Member::MemberTypes[:player]
  end

  def manager?
    self.master.member_type == Member::MemberTypes[:manager]
  end

  before_save do |r|
    r.first_name = r.master.first_name
    r.last_name = r.master.last_name
    r.uniform_number = r.master.uniform_number
    r.position_id = r.master.position_id
  end

end
