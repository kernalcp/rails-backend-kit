module Api
  module V1
    class AuthController < BaseController
      skip_before_action :authenticate_request!, only: [:login, :signup]

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user_response(user) }, status: :ok
        else
          render json: { errors: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def signup
        user = User.new(user_params)
        user.role ||= 'user'

        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user_response(user) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation, :role)
      end

      def user_response(user)
        {
          id: user.id,
          email: user.email,
          role: user.role
        }
      end
    end
  end
end
