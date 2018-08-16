require 'features_helper'

describe 'Delete the user' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit '/users'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    let(:user_params) do
      {
        email: "some@email.com",
        password: "some_password",
        role: "admin"
      }
    end

    let!(:user) { repository.create(user_params) }

    before do
      sign_in_as role
      visit "/users"
    end

    after { repository.clear }

    context 'as user' do
      let(:role) { "user" }
      it_behaves_like "protected page"
    end

    context 'as admin' do
      let(:role) { "admin" }

      it 'can delete the user' do
        expect(page).to have_selector('.user', count: 2)

        within all(".user").last do
          click_button 'delete'
        end

        expect(current_path).to eq('/users')
        expect(page).to have_selector('.user', count: 1)
      end
    end
  end
end
