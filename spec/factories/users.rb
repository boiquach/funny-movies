FactoryBot.define do
    factory :user do
      username { Faker::Twitter.screen_name }
      password  { "abc123" }
      password_confirmation { "abc123" }
    end
  end