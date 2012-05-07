# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  validates :symbol,
    uniqueness: true

  def self.foul_types
    Constants.foul_types
  end
end
