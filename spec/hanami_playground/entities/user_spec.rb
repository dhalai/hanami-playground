require_relative '../../spec_helper'

describe User, type: :entity do
  it 'can be initialized with attributes' do
    user = User.new(email: "test@email.com", password: "123", role: "admin")
    expect(user.email).to eq "test@email.com"
  end
end
