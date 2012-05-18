module ApplicationHelper

  # selectタグ用に設定するたのFoulの一覧を生成します。
  def foul_for_select(foul_type = nil)
    fouls ||= []

    if foul_type.nil?
      fouls = Foul.all
    else
      fouls = Foul.find_all_by_foul_type(foul_type)
    end

    fouls.collect do |foul|
      description = translate_constant(:foul, foul.symbol)
      [ "#{foul.symbol}#{Constants.select_separator}#{description}",  foul.id ]
    end
  end

  # foul_typeを表示用文言を取得します。
  def foul_type_for_display(value)
    translate_constant(:foul_type, Constants.foul_type.key(value))
  end

  # selectタグ用に設定するたのmember_typeの一覧を生成します。
  def member_type_for_select
    Constants.member_type.collect do |k, v|
       [ translate_constant(:member_type, k), v ]
    end
  end

  # member_typeの表示用文言を取得します。
  def member_type_for_display(value)
    translate_constant(:member_type, Constants.member_type.key(value))
  end

  # selectタグ用に設定するたのin_or_outの一覧を生成します。
  def in_or_out_for_select
    Constants.in_or_out.collect do |k, v|
       [ translate_constant(:in_or_out, k), v ]
    end
  end

  # in_or_outの表示用文言を取得します。
  def in_or_out_for_display(value)
    translate_constant(:in_or_out, Constants.in_or_out.key(value))
  end

  # stating_statusの表示用文言を取得します。
  def starting_status_for_display(value)
    translate_constant(:starting_status, Constants.starting_status.key(value))
  end

  # translation_ja.ymlのconstants配下に定義された訳語に変換します。
  # 引数はtranslation_ja.ymlで定義された階層の順番で
  # シンボル、または文字列で指定してください。
  def translate_constant(*keys)
    return if keys.blank?

    root = Constants.constants_translate_root
    keys.unshift(root)

    I18n.t(keys.map{ |s| s.to_s }.join('.'))
  end

end
