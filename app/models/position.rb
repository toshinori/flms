class Position < ActiveRecord::Base
  has_many :players,
    class_name: Member,
    foreign_key: :position_id,
    conditions: { member_type: Constants.member_type[:player] }
end
