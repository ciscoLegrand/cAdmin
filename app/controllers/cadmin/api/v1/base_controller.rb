module Cadmin
  module Api  
    module V1 
      class BaseController < ActionController::Base
        include Pagy::Backend
        protect_from_forgery with: :null_session      
        # before_action :authenticate

        def json_render(object, status: :ok)
          render json: object, status: status
        end

        rescue_from ActiveRecord::RecordInvalid do |err| 
          json_render({message: err.message}, status: :unprocessable_entity)
        end
        
        rescue_from ActiveRecord::RecordNotFound do |err| 
          json_render({message: err.message}, status: :not_found)
        end
        
        rescue_from StandardError do |err| 
          json_render({message: err.message}, status: :unprocessable_entity)
        end
  
        rescue_from ActionController::ParameterMissing do |err|
          json_render({ error: "Required parameter missing: #{err.param}" }, status: :bad_request)
        end
  
        rescue_from ArgumentError do |err|
          json_render({ error: err.message }, status: :bad_request)
        end

        private 
          # def authenticate 
          #   authenticate_with_token || unauthorized 
          # end
          
          # def authenticate_with_token 
          #   authenticate_with_http_token do  |token| 
          #     @spotify = RSpotify::authenticate('2b79ce0314b7466599c919240516959c', 'a506a8715b0b4d54bcf0d17f27fe6c9a')
          #   end
          # end

          # def unauthorized  
          #   head :unauthorized
          # end
      end
    end
  end
end