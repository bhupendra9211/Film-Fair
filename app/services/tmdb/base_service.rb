require 'uri'
require 'net/http'


module Tmdb
    class BaseService
        API_KEY = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNGZkOGM4NDBlOTIzNDM4M2FjNjEzYmJiYTU2ZWEzNiIsInN1YiI6IjY2MDY4MDQ3MzAzYzg1MDE0OWI3ZjE5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S9Z272YSyDKx5HV-tNgt8LWux8NYvtH2nrsrCQnoDa8'
        def get_request(url:)
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true

            request = Net::HTTP::Get.new(url)
            request["accept"] = 'application/json'
            request["Authorization"] = "Bearer #{API_KEY}"

            response = http.request(request)
        end

    end
end
