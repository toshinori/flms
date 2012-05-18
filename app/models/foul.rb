# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  default_scope order(:symbol)

  has_many :game_fouls

  validates :symbol,
    uniqueness: true

  def self.caution_ids
    self.where(foul_type: Constants.foul_type.caution).map{|f|f.id}
  end

  def self.dismissal_ids
    self.where(foul_type: Constants.foul_type.dismissal).map{|f|f.id}
  end

  def self.foul_types
    Constants.foul_type
  end

end
