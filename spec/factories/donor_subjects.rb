# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donor_subject do
    name "MyString"
    ident 1
    parent_id 1
  end
end
