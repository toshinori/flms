class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, through: :team_members

  validates :name,
    presence: true,
    length: { maximum: 20 }

  after_destroy do |team|
    TeamMember.destroy_all({team_id: team.id})
  end

  def add_member(member)
    TeamMember.create({team_id: self.id, member_id: member.id})
  end

  def remove_member(member)
    TeamMember.destroy_all({team_id: self.id, member_id: member.id})
  end

  def players
    members.find_all_by_member_type(Member::MemberTypes[:player])
  end

  def managers
    members.find_all_by_member_type(Member::MemberTypes[:manager])
  end
end
