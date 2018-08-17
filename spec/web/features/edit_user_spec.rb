require 'features_helper'

describe 'Edit the user' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit "/users/1/edit"
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    before do
      sign_in_as role
      visit "/users/#{user_id}/edit"
    end

    after { repository.clear }

    context 'as user' do
      let(:user_id) { 123 }
      let(:role) { "user" }
      it_behaves_like "protected page"
    end

    context 'as admin' do
      let(:role) { "admin" }

      context "nonexistent user" do
        let(:user_id) { 123 }

        it 'redirects to the users page' do
          expect(current_path).to eq('/users')
        end
      end

      context "existent user" do
        let(:user_params) do
          {
            email: "some@email.com",
            password: "some_password",
            role: "admin"
          }
        end

        let(:user) { repository.create(user_params) }
        let(:user_id) { user.id }

        context 'valid form' do
          let(:new_email) { "another@email.com" }

          it 'can update a new user' do
            within 'form#user-form' do
              fill_in 'Email', with: new_email
              fill_in 'Password', with: user.password
              choose "#{user.role}-role"

              click_button 'Update'
            end

            expect(current_path).to eq('/users')
            expect(page.has_content?(new_email)).to be true
          end
        end

        context 'invalid form' do
          let(:messages) { ["Password must be filled"] }

          it 'displays list of errors' do
            within 'form#user-form' do
              click_button 'Update'
            end

            expect(current_path).to eq("/users/#{user.id}")

            messages.each do |msg|
              expect(page.has_content?(msg)).to be true
            end
          end
        end
      end
    end
  end
end
