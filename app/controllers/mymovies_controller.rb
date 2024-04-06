class MymoviesController < ApplicationController
    def index
        @mymovies = Movie.all.includes(:reviews)
      end
      
end
