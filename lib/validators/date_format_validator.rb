# -*- coding: utf-8 -*-

class DateFormatValidator < ActiveModel::Validator
  def validate(record)
    fields ||= []
    fields << options[:field] unless options[:field].blank?
    fields << options[:fields] unless options[:fields].blank?

    fields.each do |f|
      next if record.send(f).blank?
      Date.parse(record.send(f)) rescue record.errors[f] << 'invalid format.'
    end
  end
end
