module Api
  module V1
    class UsersController < BaseController

      def index
        authorize User
        users = User.all
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        authorize user
        render json: user, status: :ok
      end
    end
  end
end
