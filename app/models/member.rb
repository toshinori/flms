class Member < ActiveRecord::Base
  MemberTypes = { none: 0, player: 1, manager: 2}.freeze
  UniformNumberRange = (1..99).freeze

  has_one :team_member
  has_one :team, through: :team_member
  has_many :game_members

  has_many :game_progresses

  validates :first_name,
    presence: true,
    length: { maximum: 10 }

  validates :last_name,
    presence: true,
    length: { maximum: 10 }

  validates :player_number,
    allow_blank: true,
    format: {with: %r(^\d{5}$)i},
    uniqueness: true

  validates :member_type,
    inclusion: { in: (Member::MemberTypes.values) }

  validates :uniform_number,
    allow_blank: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: UniformNumberRange.first,
      less_than_or_equal_to: UniformNumberRange.last
    }

end
