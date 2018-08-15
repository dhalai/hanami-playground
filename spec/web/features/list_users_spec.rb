require 'features_helper'

describe 'List users' do
  let(:repository) { UserRepository.new }
  let(:users_count) { 2 }

  before do
    repository.clear

    users_count.times do
      params = {
        email: SecureRandom.hex,
        password: SecureRandom.hex,
        role: "admin"
      }
      repository.create(params)
    end
  end

  it 'displyas each user on the page' do
    visit '/users'

    within '.users' do
      expect(page).to have_selector('.user', count: users_count)
    end
  end
end
