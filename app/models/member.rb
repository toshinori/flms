class Member < ActiveRecord::Base
  include ArrayUtility

  acts_as_paranoid
  validates_as_paranoid

  UniformNumberRange = (1..99).freeze
  MemberTypesValues = { none: 0, player: 1, manager: 2}
  Member.const_set(:MemberTypes, MemberTypesValues) unless const_defined?(:MemberTypes)
  unless const_defined?(:MemberTypesForSelect)
    Member.const_set(:MemberTypesForSelect,
                     ArrayUtility.to_select(:MemberTypes, MemberTypesValues))
  end

  def self.member_types_for_select
    ArrayUtility.to_select(:MemberTypes, MemberTypesValues)
  end

  belongs_to :position
  has_one :team_member, dependent: :destroy
  has_one :team, through: :team_member
  has_many :game_members
  has_many :game_progresses

  validates :first_name,
    presence: true,
    length: { maximum: 10 }

  validates :last_name,
    presence: true,
    length: { maximum: 10 }

  validates :player_number,
    allow_blank: true,
    format: {with: %r(^\d{10}$)i},
    uniqueness: true

  # 論理削除も考慮してユニークチェックするなら下記を使用する
  # その際、通常のuniqueness: trueは削除
  # validates_uniqueness_of_without_deleted :player_number

  validates :member_type,
    inclusion: { in: (Member::MemberTypes.values) }

  validates :uniform_number,
    allow_blank: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: UniformNumberRange.first,
      less_than_or_equal_to: UniformNumberRange.last
    }

  # validates_with DateFormatValidator,
    # allow_nil: true,
    # field: :birth_day

  # validates_each :birth_day, allow_nil: true do |record, atr, value|
    # Date.parse(value) rescue record.errors[attr] << 'invalid format.'
  # end

  def player?
    self.member_type == MemberTypes[:player]
  end

  def manager?
    self.member_type == MemberTypes[:manager]
  end

  def member_type_disp
# "MemberTypes".underscore.singularize
# model_class.model_name.human.pluralize
      # default: ! '%Y/%m/%d %H:%M:%S'
      # long: ! '%Y年%m月%d日(%a) %H時%M分%S秒 %z'
      # short: ! '%y/%m/%d %H:%M'
    I18n.t "constant.member_type.player"
  end
    #TODO positionのassociationsはあとで検討
end
