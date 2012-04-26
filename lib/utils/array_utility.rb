# -*- coding: utf-8 -*-

#TODO Rdocを書くように！！！

module ArrayUtility

  def self.to_select(name, values, key_root = 'constant')
    # h ||= {}
    # values.each do  |k, v|
      # trans_key = "#{key_root}.#{name.to_s.underscore.singularize}.#{k.to_s}"
      # h[v] = I18n.t(trans_key)
    # end
    # h

    values.collect do |k, v|
      trans_key = "#{key_root}.#{name.to_s.underscore.singularize}.#{k.to_s}"
      [ I18n.t(trans_key), v ]
    end
  end
end
