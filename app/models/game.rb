# -*- coding: utf-8 -*-
class Game < ActiveRecord::Base
  has_many :teams,
    class_name: GameTeam,
    uniq: true,
    order: :home_or_away,
    dependent: :destroy

  has_many :progresses,
    class_name: GameProgress

  validates :the_date,
    presence: true

  #TODO 開催日、開始・終了時刻の検証は後回し
end
