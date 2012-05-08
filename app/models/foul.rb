# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  has_many :game_fouls

  validates :symbol,
    uniqueness: true

  def self.foul_types
    Constants.foul_type
  end


end
