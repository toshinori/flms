class GamePlayerChange < ActiveRecord::Base
  default_scope order(:occurrence_time)

  belongs_to :player,
    class_name: GameMember,
    foreign_key: :game_member_id

  validates :game_member_id,
    presence: true

  validates :occurrence_time,
    allow_blank: false,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: Constants.game_time_range.min,
      less_than_or_equal_to: Constants.game_time_range.max
      }

  validates :in_or_out,
    allow_blank: false,
    inclusion: { in: (Constants.in_or_out.values) },
    uniqueness: { scope: :game_member_id }


  validate :starting_player_cannot_in,
    unless: ->(r) { r.game_member_id.blank? or r.in_or_out.blank? }

  # validate :cannot_out_after_in,
    # unless: ->(r) { r.game_member_id.blank? or r.in_or_out.blank? or r.occurrence_time.blank? }

  private
    def starting_player_cannot_in
      return unless self.player.starting_player?
      if self.in_or_out  == Constants.in_or_out.in
        errors.add(:in_or_out, 'Starting player cannot in.')
      end
    end

    # def cannot_out_after_in
      # changes = GamePlayerChange.find_all_by_game_member_id(self.player.id)
      # return if changes.blank?
      # return if changes.select
        # {|r| r.occurrence_time < self.occurrence_time and r.in_or_out == Constants.in_or_out}.blank?
      # # prev = GamePlayerChange.where()
    # end

end
