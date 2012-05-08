class GameProgress < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :player,
    class_name: Member,
    foreign_key: :member_id,
    conditions: { member_type: Constants.member_type[:player] }

  validates :team_id,
    presence: true

  validates :member_id,
    presence: true

end
