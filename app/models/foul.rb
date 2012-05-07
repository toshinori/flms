# -*- coding: utf-8 -*-
class Foul < ActiveRecord::Base
  def self.foul_types
    Constants.foul_types
  end
end
