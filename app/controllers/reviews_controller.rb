class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def create
      @movie = fetch_movie(params[:movie_id])
      @moviecreate = Movie.find_by(movie_id: @movie['id']) || Movie.create(movie_id: @movie['id'], title: @movie['title'], original_title: @movie['original_title'],poster: @movie['poster_path'], popularity: @movie['popularity'])
      @reviewcreate = current_user.reviews.build(review_params.merge(movie_id: @moviecreate.id))
        if @reviewcreate.save
        flash.now[:alert] = 'Review success.'
        else
        flash.now[:alert] = 'Review could not be saved.'
    
        end
        redirect_to movie_path(id: @moviecreate.movie_id)
    end
  
  
  
  
  
  
    private
  
    def fetch_movie(movie_id)
      Tmdb::DetailService.execute(id: movie_id)
    end
  
    def review_params
      params.require(:review).permit(:review)
  
    end
end
