require 'features_helper'

describe 'Paginate users' do
  let(:repository) { UserRepository.new }

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

  context "without pagination" do
    let(:users_count) { 2 }

    it 'displyas each user on the page' do
      visit '/users'

      within '.users' do
        expect(page).to have_selector('.user', count: users_count)
      end
    end

    it 'does not display the pagination' do
      visit '/users'
      expect(page).to_not have_selector('.paginator')
    end
  end

  context "with pagination" do
    let(:users_count) { 20 }
    let(:users_per_page) { 10 }

    it 'displyas each user on the page' do
      visit '/users'

      within '.users' do
        expect(page).to have_selector('.user', count: users_per_page)
      end
    end

    it 'displays the pagination' do
      visit '/users'
      expect(page).to have_selector('.paginator')
    end

    it 'displays the pagination links' do
      visit '/users'

      within '.paginator' do
        expect(page).to have_selector('a', count: (users_count / users_per_page))
      end
    end
  end
end
