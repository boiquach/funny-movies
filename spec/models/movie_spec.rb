# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject do
    described_class.new(title: 'Anything',
                        description: 'Lorem ipsum',
                        link: 'https://www.youtube.com/watch?v=-tKVN2mAKRI',
                        thumbnail: 'https://i.ytimg.com/vi/DDWKuo3gXMQ/mqdefault.jpg',
                        shared_by_id: FactoryBot.create(:user).id)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a link' do
    subject.link = nil
    expect(subject).to_not be_valid
  end
end
