class Team < ActiveRecord::Base
  acts_as_paranoid

  has_many :team_members,
    dependent: :destroy

  has_many :members,
    through: :team_members

  has_many :players,
    through: :team_members,
    source: :member,
    conditions: { member_type: Constants.member_type[:player] }

  has_many :managers,
    through: :team_members,
    source: :member,
    conditions: { member_type: Constants.member_type[:manager] }

  has_many :home_games,
    class_name: GameTeam,
    foreign_key: :team_id,
    conditions: { home_or_away: GameTeam.home_or_away[:home] },
    order: { the_date: :asc }

  has_many :away_games,
    class_name: GameTeam,
    foreign_key: :team_id,
    conditions: { home_or_away: GameTeam.home_or_away[:away] },
    order: { the_date: :asc }

  validates :name,
    presence: true,
    length: { maximum: 20 }

  def games
    (self.home_games | self.away_games).sort {|x, y| x.the_date <=> y.the_date}
  end

end
