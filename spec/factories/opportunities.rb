# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opportunity do
    partner_name "MyString"
    program_name "MyString"
    location "MyString"
    due_date "MyString"
    details "MyText"
    link "MyString"
    additional "MyText"
    video "MyString"
  end
end
