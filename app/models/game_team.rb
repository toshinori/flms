class GameTeam < ActiveRecord::Base

  belongs_to :game

  belongs_to :master,
    class_name: Team,
    foreign_key: :team_id

  has_many :members,
    class_name: GameMember

  has_many :goals,
    class_name: GameGoal,
    through: :members,
    foreign_key: :game_member_id

  has_many :fouls,
    class_name: GameFoul,
    through: :members,
    foreign_key: :game_member_id

  has_many :changes,
    class_name: GamePlayerChange,
    through: :members,
    foreign_key: :game_member_id

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

  def starting_players
    self.members.find_all {|m| m.starting_player?}
  end

  def reserve_players
    self.members.find_all {|m| m.reserve_player?}
  end

  def can_add_starting_player?
    (self.starting_players.size < Constants.starting_player_max)
  end

  def can_add_reserve_player?
    true
  end

  def out_of_bench_players
    ids = self.players.map {|p| p.member_id}
    self.master.players.select {|p| p unless ids.include?(p.id)}
  end

  def player_masters
    self.players.map {|p| p.master}
  end

  def self.home_or_away
    Constants.home_or_away
  end


end
