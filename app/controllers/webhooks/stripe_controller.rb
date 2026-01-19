class Webhooks::StripeController < ApplicationController::API
  skip_before_action :verify_authenticity_token

  def receive
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
      handle_event(event)
      head :ok
    rescue JSON::ParserError => e
      render json: { message: "Invalid payload" }, status: 400 and return
    rescue Stripe::SignatureVerificationError => e
      render json: { message: "Invalid signature" }, status: 400 and return
    end
  end

  private

  def handle_event(event)
    case event.type
    # when 'customer.subscription.created'
    #   subscription = event.data.object
    #   Subscription.find_by(stripe_subscription_id: subscription.id)&.update(status: subscription.status)
    when 'customer.subscription.deleted'
      subscription = event.data.object
      Subscription.find_by(stripe_subscription_id: subscription.id)&.update(status: 'canceled') if subscription.present?
    else
      Rails.logger.info "Unhandled event type: #{event.type}"
    end
  end
end