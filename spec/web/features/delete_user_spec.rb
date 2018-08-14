require 'features_helper'

describe 'Delete the user' do
  let(:repository) { UserRepository.new }
  let(:user_params) do
    {
      email: "some@email.com",
      password: "some_password",
      role: "admin"
    }
  end
  let!(:user) { repository.create(user_params) }

  before { visit "/users" }
  after { repository.clear }

  it 'can delete the user' do
    expect(page.has_content?(user.email)).to be true

    click_button 'delete'

    expect(current_path).to eq('/users')
    expect(page.has_content?(user.email)).to be false
  end
end
