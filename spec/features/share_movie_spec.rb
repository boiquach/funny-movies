# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sharing a Movie', type: :feature do
  before do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
  end

  scenario 'input is a Youtube link' do
    visit movies_path
    click_on 'Share'
    fill_in 'Youtube URL', with: 'https://www.youtube.com/watch?v=DDWKuo3gXMQ'
    click_on 'Share'
    expect(page).to have_content('Adele - When We Were Young (Live at The Church Studios)')
  end

  scenario 'input is not a link' do
    visit movies_path
    click_on 'Share'
    fill_in 'Youtube URL', with: 'aabc'
    click_on 'Share'
    expect(page).to have_content('Please provide a valid link.')
  end

  scenario 'input is not a video link' do
    visit movies_path
    click_on 'Share'
    fill_in 'Youtube URL', with: 'https://twitter.com/home'
    click_on 'Share'
    expect(page).to have_content('Please provide a valid link.')
  end

  scenario 'input is a video link but video is not available' do
    visit movies_path
    click_on 'Share'
    fill_in 'Youtube URL', with: 'https://www.youtube.com/watch?v=N-xcYytDaIc'
    click_on 'Share'
    expect(page).to have_content('Please provide an available video.')
  end

  scenario 'input is a video link but video is not from Youtube' do
    visit movies_path
    click_on 'Share'
    fill_in 'Youtube URL', with: 'https://www.dailymotion.com/video/x7lni3'
    click_on 'Share'
    expect(page).to have_content('Please provide a Youtube link.')
  end
end
