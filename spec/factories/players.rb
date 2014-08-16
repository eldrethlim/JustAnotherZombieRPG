# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    username {|n| "player#{n}"}
    email {|n| "player#{n}@example.com"}
    password "helloworld"
  end
end
