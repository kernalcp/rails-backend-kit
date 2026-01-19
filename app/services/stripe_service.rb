class StripeService
  def self.create_subscription(customer_id, price_id)
    Stripe::Subscription.create({
      customer: customer_id,
      items: [{ price: price_id }],
      expand: ['latest_invoice.payment_intent']
    })
  end
end