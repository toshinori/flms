# -*- coding: utf-8 -*-
class Game < ActiveRecord::Base
  has_many :teams,
    class_name: GameTeam,
    uniq: true,
    order: :home_or_away,
    dependent: :destroy

  has_one :home_team,
    class_name: GameTeam,
    foreign_key: :team_id,
    conditions: { home_or_away: GameTeam::HomeOrAway[:home] }

  has_one :away_team,
    class_name: GameTeam,
    foreign_key: :team_id,
    conditions: { home_or_away: GameTeam::HomeOrAway[:away] }

  has_many :progresses,
    class_name: GameProgress

  validates :the_date,
    presence: true

  #TODO 開催日、開始・終了時刻の検証は後回し、プラグインの使用を検討
end
