# -*- coding: utf-8 -*-
class Game < ActiveRecord::Base
  belongs_to :home_team,
    foreign_key: :home_team_id,
    class_name: Team

  belongs_to :away_team,
    foreign_key: :away_team_id,
    class_name: Team

  validates :home_team_id,
    presence: true

  validates :away_team_id,
    presence: true

  validates_with FieldsEquivalentValidator,
    fields: [:home_team_id, :away_team_id]

end
