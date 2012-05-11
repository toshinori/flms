class GameMember < ActiveRecord::Base

  belongs_to :team,
    class_name: GameTeam,
    foreign_key: :game_team_id

  belongs_to :master,
    class_name: Member,
    foreign_key: :member_id

  belongs_to :position

  has_many :fouls,
    class_name: GameFoul,
    order: :occurrence_time

  has_many :goals,
    class_name: GameGoal,
    order: :occurrence_time

  has_many :changes,
    class_name: GamePlayerChange,
    order: :occurrence_time

  validates :game_team_id,
    presence: true

  validates :member_id,
    presence: true

  validates :starting_status,
    allow_blank: true,
    inclusion: { in: (Constants.starting_status.values) }

  def player?
    self.master.player?
  end

  def starting_player?
    self.player? and self.starting_status == Constants.starting_status.starting
  end

  def reserve_player?
    self.player? and self.starting_status == Constants.starting_status.reserve
  end

  def manager?
    self.master.manager?
  end

  before_save do |r|
    r.first_name = r.master.first_name
    r.last_name = r.master.last_name
    r.uniform_number = r.master.uniform_number
    r.position_id = r.master.position_id
  end

end
