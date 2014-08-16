# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :episode_timestamp do
    timestamp 1
    description "MyText"
    episode nil
  end
end
