class MoviesController < ApplicationController
  def index
    if params[:movie_title].present?
      @movies = Tmdb::SearchService.execute(title: params[:movie_title])
    else
      @movies = Tmdb::AllService.execute()
    end
  end

  # def create
  #     @title = Movie.create(movie_params)
  #     redirect_to root_path
  # end

  def show
    @movie=Movie.find_by(movie_id: params[:id])
    if @movie.nil?
      @moviecreate = Tmdb::DetailService.execute(id: params[:id])
    end
  end

  # private
  # def movie_params
  #     params.require(:movie).permit(:title)
  # end
   
end
