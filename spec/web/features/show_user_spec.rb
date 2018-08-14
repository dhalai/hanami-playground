require 'features_helper'

describe 'Show the user' do
  let(:repository) { UserRepository.new }
  let(:user_params) do
    {
      email: "some@email.com",
      password: "some_password",
      role: "admin"
    }
  end
  let!(:user) { repository.create(user_params) }

  before { visit "/users/#{user.id}" }
  after { repository.clear }

  it 'shows the user' do
    user.to_h.each do |column, value|
      expect(page.has_content?(column.capitalize)).to be true
      expect(page.has_content?(value)).to be true
    end
  end
end
