require 'forwardable'

class GameMember < ActiveRecord::Base
  extend Forwardable

  belongs_to :game_team
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

  has_many :substitutions,
    class_name: GamePlayerSubstitution,
    order: :occurrence_time

  validates :game_team_id,
    presence: true

  validates :member_id,
    presence: true

  validates :starting_status,
    allow_blank: true,
    inclusion: { in: (Constants.starting_status.values) }

  validate :can_add_starting_player,
    on: :create,
    if: ->(r) { not r.team.blank? and r.starting_player? }

  def_delegator :master, :player?
  def_delegator :master, :manager?
  #TODO full_nameの扱いを検討
  def_delegator :master, :full_name

  def starting_player?
    self.player? and self.starting_status == Constants.starting_status.starting
  end

  def reserve_player?
    self.player? and self.starting_status == Constants.starting_status.reserve
  end

  before_save do |r|
    r.first_name = r.master.first_name
    r.last_name = r.master.last_name
    r.uniform_number = r.master.uniform_number
    r.position_id = r.master.position_id
  end

  private
    def can_add_starting_player
      unless self.team.can_add_starting_player?
        errors.add(:game_team_id, 'Starting player is over.')
      end
    end
end
