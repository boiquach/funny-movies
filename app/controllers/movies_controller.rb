# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @movies = Movie.all.order(created_at: :desc)
  end

  def new; end

  def create
    link = movie_params[:link]
    video = VideoInfo.new(link)

    redirect_to new_movie_path, alert: 'Please provide an available video.' and return unless video.available?
    unless video.provider == 'YouTube'
      redirect_to new_movie_path,
                  alert: 'Please provide a Youtube link.' and return
    end

    movie = Movie.new(title: video.title, description: video.description,
                      thumbnail: video.thumbnail_medium, shared_by: current_user,
                      link: link)

    redirect_to movies_path and return if movie.save

    redirect_to new_movie_path, alert: 'Failed to save. Please try again' and return
  rescue StandardError
    redirect_to new_movie_path, alert: 'Please provide a valid link.'
  end

  private

  def movie_params
    params.permit(:link)
  end

  def set_api_key
    VideoInfo.provider_api_keys = { youtube: 'AIzaSyCXNOfwIqxAgF8MISE4f13psUvn4kb9T1A' }
  end
end
