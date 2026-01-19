Stripe.api_key = ENV['STRIPE_API_KEY']

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.created', 'Subscriptions::Created'
  events.subscribe 'customer.subscription.deleted', 'Subscriptions::Deleted'
end
