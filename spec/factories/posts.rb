# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user_id 1
    organization_id 1
    body "MyText"
  end
end
