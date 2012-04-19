class TeamMember < ActiveRecord::Base
  belongs_to :team, dependent: :destroy
  belongs_to :member, dependent: :destroy

  validates :team_id,
    presence: false,
    uniqueness: { scope: :member_id }

  validates :member_id,
    presence: false
end
