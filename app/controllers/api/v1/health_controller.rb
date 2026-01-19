module Api
  module V1
    class HealthController < BaseController
        def index
          render json: { status: 'OK', message: 'Service is running', user: current_user.email }, status: :ok
        end
    end
  end
end
