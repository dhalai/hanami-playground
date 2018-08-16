require 'features_helper'

describe 'List users' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit '/users/'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    let(:users_count) { 2 }

    before do
      sign_in_as role
      visit "/users/"
    end

    after { repository.clear }

    context 'as user' do
      let(:role) { "user" }
      it_behaves_like "protected page"
    end

    context 'as admin' do
      let(:role) { "admin" }

      before do
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
          expect(page).to have_selector('.user', count: users_count + 1)
        end
      end
    end
  end
end
