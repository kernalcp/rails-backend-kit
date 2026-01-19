#Rails Backend Kit (Rails 8.1.2)

A production-ready Rails 8 API boilerplate with authentication, roles, background jobs, and Stripe subscriptions - built for modern startups.

## Features
- JWT-based authentication
- Role-based authorization (admin/user)
- Background jobs with Sidekiq + Redis
- Stripe subscriptions & webhooks
- Standardized API responses
- API versioning (v1)

## Tech Stack
- Ruby on Rails 8.1.1 (API-only)
- PostgreSQL
- Sidekiq + Redis
- Stripe

## Setup
```
git clone https://github.com/kernalcp/rails-backend-kit.git
bundle install
rails db:create db:migrate db:seed
rails s
```

## API Example
```
POST /api/v1/auth/login
Authorization: Bearer <token>
```

