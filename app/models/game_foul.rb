class GameFoul < ActiveRecord::Base
  default_scope order(:occurrence_time)

  belongs_to :player,
    class_name: GameMember,
    foreign_key: :game_member_id

  belongs_to :foul

  validates :game_member_id,
    presence: true

  validates :foul_id,
    presence: true

  validates :occurrence_time,
    allow_blank: false,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: Constants.game_time_range.min,
      less_than_or_equal_to: Constants.game_time_range.max
      }

  validate :already_dismiss_player,
    on: :create,
    if: ->(r) { not r.foul.blank? and r.foul.foul_type == Constants.foul_type.dismissal }

  after_create do |r|
    return unless r.foul.foul_type == Constants.foul_type.dismissal
    substitution = GamePlayerSubstitution.new(
      game_member_id: r.game_member_id,
      in_or_out: Constants.in_or_out.out,
      occurrence_time: r.occurrence_time
    )
    return unless substitution.valid?
    substitution.save
  end

  after_destroy do |r|
    return unless r.foul.foul_type == Constants.foul_type.dismissal
    substitution =
      GamePlayerSubstitution.find_by_game_member_id_and_in_or_out_and_occurrence_time(
        r.game_member_id,
        Constants.in_or_out.out,
        r.occurrence_time)
    return if substitution.blank?
    substitution.destroy
  end

  #TODO 選手交代との関連を考慮した制御を追加する
  private
    def already_dismiss_player
      return if GameFoul.where(game_member_id: self.game_member_id, foul_id: Foul.dismissal_ids).blank?
      errors.add(:base, 'This player was already dismiss.')
    end

end
