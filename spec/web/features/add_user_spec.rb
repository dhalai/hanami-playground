require 'features_helper'

describe 'Add a user' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit '/users/new'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    let(:email) { 'test@email.com' }
    let(:password) { 'some_password' }

    before do
      sign_in_as role
      visit '/users/new'
    end

    after { repository.clear }

    context 'as user' do
      let(:role) { "user" }
      it_behaves_like "protected page"
    end

    context 'as admin' do
      let(:role) { "admin" }

      context 'valid form' do
        it 'can create a new user' do
          within 'form#user-form' do
            fill_in 'Email', with: email
            fill_in 'Password', with: password
            choose "#{role}-role"

            click_button 'Create'
          end

          expect(current_path).to eq('/users')
          expect(page.has_content?('New User')).to be true
        end
      end

      context 'invalid form' do
        let(:messages) do
          [
            "Email must be filled",
            "Password must be filled",
            "Role is missing"
          ]
        end

        it 'displays list of errors' do
          within 'form#user-form' do
            click_button 'Create'
          end

          expect(current_path).to eq('/users')

          messages.each do |msg|
            expect(page.has_content?(msg)).to be true
          end
        end
      end
    end
  end
end
