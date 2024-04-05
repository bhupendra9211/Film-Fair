class V1::ReviewsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user_using_api_key
    def index
        movie = Movie.find_by(movie_id: params[:movie_id])
        if movie
            reviews = movie.reviews.map { |review| { user_id: review.user_id, review: review.review } } 
            render json: { 
                movie_id: movie.movie_id,
                review_count: movie.reviews.count,
                reviews: reviews
            }, status: 200
        else
            @movie = fetch_movie(params[:movie_id])
            if @movie['id']
                @moviecreate = Movie.find_by(movie_id: @movie['id']) || Movie.create(movie_id: @movie['id'], title: @movie['title'], original_title: @movie['original_title'],poster: @movie['poster_path'], popularity: @movie['popularity'])
                if @moviecreate
                    render json: {
                        movie_id: @moviecreate.movie_id, 
                        review_count: @moviecreate.reviews.count,
                        reviews: @moviecreate.reviews.map { |review| { user_id: review.user_id, review: review.review } }
                    }, status: 200
                end
            end
            
            if (@movie[  "status_code"] == 6)
                render json: { error: "Invalid id: The pre-requisite id is invalid or not found."}
            end

            if (@movie[  "status_code"] == 34)
                render json: { error: "The resource you requested could not be found."},status: 404
            end

        end
    end

    def create
        movie = Movie.find_by(movie_id: params[:movie_id])
        if movie
            Review.create(review_params.merge(user_id: current_user.id, movie_id: movie.id))
            reviews = movie.reviews.map { |review| { user_id: review.user_id, review: review.review } } 
            render json: { 
                movie_id: movie.movie_id,
                review_count: movie.reviews.count,
                reviews: reviews
            }, status: 200
        else
            movie = fetch_movie(params[:movie_id])
            if movie['id']
                Movie.create(movie_id: movie['id'], title: movie['title'], original_title: movie['original_title'],poster: movie['poster_path'], popularity: movie['popularity'])

                movie = Movie.find_by(movie_id: params[:movie_id])
                Review.new(review_params.merge(user_id: current_user.id, movie_id: movie.id))

                reviews = movie.reviews.map { |review| { user_id: review.user_id, review: review.review } } 
                render json: { 
                    movie_id: movie.movie_id,
                    review_count: movie.reviews.count,
                    reviews: reviews
                }, status: 200
            end
            
            if (movie[ "status_code"] == 6 )
                render json: { error: "Invalid id: The pre-requisite id is invalid or not found."}
            end

            if (movie[  "status_code"] == 34)
                render json: { error: "The resource you requested could not be found."}
            end

        end
    end

    private

    def fetch_movie(movie_id)
        Tmdb::DetailService.execute(id: movie_id)
    end

    def review_params
        params.require(:review).permit(:review)
    end

    def authenticate_user_using_api_key
        api_key = request.headers['x-api-key']
        @current_user = User.find_by(api_key: api_key)
        unless @current_user
          render json: { error: 'User not authenticated' }, status: :unauthorized
        end
      end

end
