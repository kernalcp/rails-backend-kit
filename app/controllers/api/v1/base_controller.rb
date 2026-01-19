module Api
  module V1
    class BaseController < ApplicationController
      include Pundit
      before_action :authenticate_request!

      rescue_from Pundit::NotAuthorizedError do
        render json: { errors: 'You are not authorized to perform this action.' }, status: :forbidden
      end

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      private

      def authenticate_request!
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        begin
          decoded = JsonWebToken.decode(token)
          @current_user = User.find(decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end

      def current_user
        @current_user
      end

      def record_not_found
        render json: error_response('Record not found' ), status: :not_found
      end

      def unprocessable_entity
        render json: error_response('Record invalid' ), status: :unprocessable_entity
      end

      def error_response(message)
        { success: false, errors: message }
      end

      def success_response(data = {}, message = 'Success')
        { success: true, message: message, data: data }
      end
  end
end
