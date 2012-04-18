class Member < ActiveRecord::Base
  MemberTypes = { none: 0, player: 1, manager: 2}

  has_one :team_member
  has_one :team, through: :team_member

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
end
