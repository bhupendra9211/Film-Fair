class Api::V1::MoviesreviewsController < ApplicationController
    def index
        reviews = Review.all
        render json: reviews, status:200
    end

    def show
        movie = Movie.find_by(id: params[:id])
        review = Review.find_by(id: params[:id])
        if movie 
            render json: {review: review}
        else
            render json: {error: "Not found"}
        end
    end

end