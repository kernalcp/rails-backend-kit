module Api
  module V1
    class UsersController < BaseController

      def index
        authorize User
        users = User.all
        render json: success_response(users), status: :ok
      end

      def show
        user = User.find(params[:id])
        authorize user
        render json: success_response(user), status: :ok
      end
    end
  end
end
