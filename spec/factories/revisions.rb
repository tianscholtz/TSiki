# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :revision do
    title "MyString"
    body "MyText"
    entry nil
    user nil
    editor "MyString"
  end
end
