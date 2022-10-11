# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  before do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
  end

  describe 'GET /movies' do
    let!(:movies) { FactoryBot.create_list(:movie, 4) }

    it 'contains the product names' do
      get '/movies'
      expect(response).to render_template(:index)
    end
  end

  describe 'POST /movies' do
    it 'creates a new movie' do
      expect { post '/movies', params: { link: 'https://www.youtube.com/watch?v=-tKVN2mAKRI' } }.to change {
                                                                                                      Movie.count
                                                                                                    }.by(1)
    end

    it 'redirects to home' do
      post '/movies', params: { link: 'https://www.youtube.com/watch?v=-tKVN2mAKRI' }
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'GET /movies/new' do
    it 'renders new' do
      get '/movies/new'
      expect(response).to render_template(:new)
    end
  end
end
