# -*- coding: utf-8 -*-

class FieldsEquivalentValidator < ActiveModel::Validator
  def validate(record)
    prev = nil
    valid = true

    options[:fields].each do |f|
      unless prev.nil? and record[f].nil?
        if prev == record[f]
          valid = false
          break
        end
      end
      prev = record[f]
    end

    record.errors[options[:fields][0]] << 'hogehoge' unless valid
  end
end
