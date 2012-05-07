# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  FoulSeeds = [
    { symbol: 'C1', description: '反スポーツマン的行為', foul_type: Constants.foul_types[:caution] },
    { symbol: 'C2', description: 'ラフプレイ', foul_type: Constants.foul_types[:caution] },
    { symbol: 'C3', description: '異議', foul_type: Constants.foul_types[:caution] },
    { symbol: 'S1', description: '著しく不正なプレイ', foul_type: Constants.foul_types[:dismissal] },
    { symbol: 'S2', description: '乱暴な行為', foul_type: Constants.foul_types[:dismissal] },
  ]
  def self.foul_types
    Constants.foul_types
  end
end
