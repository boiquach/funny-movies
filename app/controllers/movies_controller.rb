class MoviesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @movies = Movie.all.order(created_at: :desc)
    end

    def new
    end

    def create
        begin
            link = movie_params[:link]
            video = VideoInfo.new(link)

            redirect_to new_movie_path, alert: "Please provide an available video." and return unless video.available? 
            redirect_to new_movie_path, alert: "Please provide a Youtube link." and return unless video.provider == 'YouTube' 
    
            movie = Movie.new(title: video.title, description: video.description,
                              thumbnail: video.thumbnail_medium, shared_by: current_user,
                              link: link)

            if movie.save
                redirect_to movies_path and return
            else
                redirect_to new_movie_path, alert: 'Failed to save. Please try again' and return
            end
        rescue
            redirect_to new_movie_path, alert: 'Please provide a valid link.'
        end
    end

    private

    def movie_params
        params.permit(:link)
    end

    def set_api_key
        VideoInfo.provider_api_keys = { youtube: 'AIzaSyCXNOfwIqxAgF8MISE4f13psUvn4kb9T1A' }
    end
end
