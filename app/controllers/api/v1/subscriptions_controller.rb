module Api
  module V1
    class SubscriptionsController < BaseController
      def create
        customer_id = current_user.stripe_customer_id

        if customer_id.nil?
          Stripe::Customer.create({
            email: current_user.email
          }).tap do |customer|
            # current_user.update(stripe_customer_id: customer.id)
            customer_id = customer.id
          end
        end

        sub = StripeService.create_subscription(
          customer_id,
          params[:price_id]
        )

        Subscription.create(
          user: current_user,
          stripe_subscription_id: sub.id,
          status: sub.status,
          plan: params
        )

        render json: success_response({}, 'Subscription created successfully'), status: :created
      rescue Stripe::StripeError => e
        render json: error_response(e.message), status: :unprocessable_entity
      end
    end
  end
end
