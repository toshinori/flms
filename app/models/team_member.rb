class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :member

  validates :team_id,
    presence: false,
    uniqueness: { scope: :member_id }

  validates :member_id,
    presence: false
end
