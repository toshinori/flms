class TeamMember < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :team
  belongs_to :member

  validates :team_id,
    presence: false,
    uniqueness: { scope: :member_id }

  validates :member_id,
    presence: false
end
