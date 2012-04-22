class GameMember < ActiveRecord::Base
  StatingStatuses = { none: 0, stating: 1, reserve: 2 }
  belongs_to :game_team
  belongs_to :master,
    class_name: Member,
    foreign_key: :member_id

  validates :starting_status,
    presence: true,
    inclusion: { in: (StatingStatuses.values) }
  #TODO 試合に関する正規化崩しを検討中
end
