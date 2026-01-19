class User < ApplicationRecord
  has_secure_password

  ROLES = %w[admin user].freeze
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: ROLES }
end
