require 'features_helper'

describe 'Sign out' do
  let(:repository) { UserRepository.new }

  before do
    sign_in_as "admin"
    visit '/'
  end

  after { repository.clear }

  it 'redirects to the sign in page' do
    within 'form#session-form' do
      click_button 'Sign out'
    end

    expect(current_path).to eq('/sessions/new')
  end
end
