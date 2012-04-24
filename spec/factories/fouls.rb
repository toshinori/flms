# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :foul do
    symbol "MyString"
    decription "MyString"
    foul_type 1
  end
end
