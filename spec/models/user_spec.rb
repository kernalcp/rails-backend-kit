require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with email and password' do
    user = User.new(email: 'test@test.com', password: 'password', role: 'user')
    expect(user).to be_valid
  end
end
