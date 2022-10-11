FactoryBot.define do
    factory :user do
      username { "abc" }
      password  { "abc123" }
      password_confirmation { "abc123" }
    end
  end