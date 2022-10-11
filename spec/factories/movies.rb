FactoryBot.define do
    factory :movie do
      title { Faker::Book.title }
      link { 'https://www.youtube.com/watch?v=-tKVN2mAKRI' }
      thumbnail { 'https://i.ytimg.com/vi/DDWKuo3gXMQ/mqdefault.jpg' }
      description { Faker::Movies::HarryPotter.quote }
      shared_by { create(:user) }
    end
  end