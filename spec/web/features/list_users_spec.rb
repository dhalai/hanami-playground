require 'features_helper'

describe 'List users' do
  let(:repository) { UserRepository.new }

  before do
    repository.clear

    2.times do
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
      expect(page).to have_selector('.user', count: 2)
    end
  end
end
