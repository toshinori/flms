# -*- coding: utf-8 -*-

class AssociationRecordCountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # if record[attribute] == nil or record[attribute].count != options[:count]
    association_count = eval("record.#{attribute}.count")
    if options[:count] != association_count
      record.errors[:base] << 'record count error'

    end
    # end
  end
end
