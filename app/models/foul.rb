# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  FoulTypes = { none: 0, caution: 1, dismissal: 2 }
  #TODO seed.rbで登録するデータはyamlなどで管理することを検討
  FoulSeeds = [
    { symbol: 'C1', description: '反スポーツマン的行為', foul_type: FoulTypes[:caution] },
    { symbol: 'C2', description: 'ラフプレイ', foul_type: FoulTypes[:caution] },
    { symbol: 'C3', description: '異議', foul_type: FoulTypes[:caution] },
    { symbol: 'S1', description: '著しく不正なプレイ', foul_type: FoulTypes[:dismissal] },
    { symbol: 'S2', description: '乱暴な行為', foul_type: FoulTypes[:dismissal] },
  ]
end
