class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, through: :team_members

  has_many :players,
    through: :team_members,
    source: :member,
    conditions: { member_type: Member::MemberTypes[:player] }

  has_many :managers,
    through: :team_members,
    source: :member,
    conditions: { member_type: Member::MemberTypes[:manager] }

  has_many :home_games,
    source: :game,
    foriegn_key: :team_id

  validates :name,
    presence: true,
    length: { maximum: 20 }

end
