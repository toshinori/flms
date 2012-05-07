class Position < ActiveRecord::Base
  Positions = %w(GK DF MF FW)

  has_many :players,
    class_name: Member,
    foreign_key: :position_id,
    conditions: { member_type: Constants.member_types[:player] }
end
