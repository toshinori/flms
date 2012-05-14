# -*- coding: utf-8 -*-
class Game < ActiveRecord::Base
  default_scope order(:the_date, :start_time)
  #TODO 開催日、開始・終了時刻の検証は後回し、プラグインの使用を検討
  #TODO チームの登録状況などを確認する検証を追加する

  has_many :teams,
    class_name: GameTeam,
    uniq: true,
    order: :home_or_away,
    dependent: :destroy

  has_one :home_team,
    class_name: GameTeam,
    foreign_key: :game_id,
    conditions: { home_or_away: Constants.home_or_away[:home] }

  has_one :away_team,
    class_name: GameTeam,
    foreign_key: :game_id,
    conditions: { home_or_away: Constants.home_or_away[:away] }

  has_many :fouls,
    class_name: GameFoul,
    through: :game_teams

  has_many :goals,
    class_name: GameGoal,
    through: :game_teams

  has_many :player_changes,
    class_name: GamePlayerChange,
    through: :game_teams

  validates :the_date,
    presence: true

  def self.game_time_range
    (Constants.game_time_range.min..Constants.game_time_range.max)
  end

end

