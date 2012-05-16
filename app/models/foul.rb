# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  default_scope order(:symbol)

  has_many :game_fouls

  validates :symbol,
    uniqueness: true

  def self.foul_types
    Constants.foul_type
  end

end
