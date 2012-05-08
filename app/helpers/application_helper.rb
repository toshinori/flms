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
      [ foul.id, "#{foul.symbol} #{description}" ]
    end
  end

  # selectタグ用に設定するたのmember_typeの一覧を生成します。
  def member_type_for_select
    Constants.member_type.collect do |k, v|
       [ translate_constant(:member_type, k), v ]
    end
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
